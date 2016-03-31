//
//  UILabel+Typeset.m
//  Typeset
//
//  Created by Draveness on 16/3/31.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import "UILabel+Typeset.h"
#import <objc/runtime.h>

@implementation UILabel (Typeset)

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
    if (self.text) self.attributedText = typesetBlock(self.text);
    objc_setAssociatedObject(self, @selector(typesetBlock), [typesetBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
