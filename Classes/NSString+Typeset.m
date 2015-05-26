//
//  NSString+Typeset.m
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "NSString+Typeset.h"
#import "TypesetKit.h"
#import "TypesetKit+Color.h"
#import <objc/runtime.h>

@implementation NSString (Typeset)

- (TypesetKit *)typeset {
    TypesetKit *typeset = objc_getAssociatedObject(self, @selector(typeset));
    if (!typeset) {
        typeset = [[TypesetKit alloc] init];
        typeset.string = [[NSMutableAttributedString alloc] initWithString:self];
        objc_setAssociatedObject(self, @selector(typeset), typeset, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return typeset;
}

- (NSMutableAttributedString *)black {
    return self.typeset.black.string;
}

- (NSMutableAttributedString *)darkGray {
    return self.typeset.darkGray.string;
}

- (NSMutableAttributedString *)lightGray {
    return self.typeset.lightGray.string;
}

- (NSMutableAttributedString *)white {
    return self.typeset.white.string;
}

- (NSMutableAttributedString *)gray {
    return self.typeset.gray.string;
}

- (NSMutableAttributedString *)red {
    return self.typeset.red.string;
}

- (NSMutableAttributedString *)green {
    return self.typeset.green.string;
}

- (NSMutableAttributedString *)blue {
    return self.typeset.blue.string;
}

- (NSMutableAttributedString *)cyan {
    return self.typeset.cyan.string;
}

- (NSMutableAttributedString *)yellow {
    return self.typeset.yellow.string;
}

- (NSMutableAttributedString *)magenta {
    return self.typeset.magenta.string;
}

- (NSMutableAttributedString *)orange {
    return self.typeset.orange.string;
}

- (NSMutableAttributedString *)purple {
    return self.typeset.purple.string;
}

- (NSMutableAttributedString *)brown {
    return self.typeset.brown.string;
}

- (NSMutableAttributedString *)clear {
    return self.typeset.clear.string;
}

- (NSMutableAttributedString *(^)(UIColor *))color {
    return ^(UIColor *color) {
        return self.typeset.color(color).string;
    };
}

- (NSMutableAttributedString *(^)(NSUInteger))hexColor {
    return ^(NSUInteger hexColor) {
        return self.typeset.hexColor(hexColor).string;
    };
}

@end
