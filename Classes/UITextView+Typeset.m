//
//  UITextView+Typeset.m
//  Typeset
//
//  Created by Draveness on 7/24/16.
//  Copyright © 2016 DeltaX. All rights reserved.
//

#import "UITextView+Typeset.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UITextView (Typeset)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(setText:);
        SEL swizzledSelector = @selector(typeset_setText:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });

    // Swizzle dealoc to remove observer when current object is deallocated.
    Class classToSwizzle = [UITextView class];
//    NSString *className = NSStringFromClass(classToSwizzle);
    SEL deallocSelector = sel_registerName("dealloc");

    __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;

    id newDealloc = ^(__unsafe_unretained id objSelf) {
        [objSelf removeObserver:self];

        if (originalDealloc == NULL) {
            struct objc_super superInfo = {
                .receiver = objSelf,
                .super_class = class_getSuperclass(classToSwizzle)
            };

            void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
            msgSend(&superInfo, deallocSelector);
        } else {
            originalDealloc(objSelf, deallocSelector);
        }
    };

    IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);

    if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
        // The class already contains a method implementation.
        Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);

        // We need to store original implementation before setting new implementation
        // in case method is called at the time of setting.
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);

        // We need to store original implementation again, in case it just changed.
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
    }
}

- (void)typeset_setText:(NSString *)text {
    if (self.typesetBlock && text) {
        self.attributedText = self.typesetBlock(text);
    } else {
        [self typeset_setText:text];
    }
}

- (NSAttributedString *(^)(NSString *))typesetBlock {
    return objc_getAssociatedObject(self, @selector(typesetBlock));
}

- (void)setTypesetBlock:(NSAttributedString *(^)(NSString *))typesetBlock {
    if (self.text && typesetBlock) self.attributedText = typesetBlock(self.text);

    // Call textViewDidChange: method when text changed
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];

    objc_setAssociatedObject(self, @selector(typesetBlock), [typesetBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)textViewDidChange:(NSNotification *)notification {
    UITextView *textView = notification.object;

    if (textView.typesetBlock && textView.text) {
        textView.attributedText = textView.typesetBlock(textView.text);
    }
}

@end
