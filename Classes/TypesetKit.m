//
//  TypesetKit.m
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "TypesetKit.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface TypesetKit ()

@property (nonatomic, assign) NSRange attributeRange;

@property (nonatomic, assign) NSInteger attributeFrom;
@property (nonatomic, assign) NSInteger attributeTo;

@property (nonatomic, assign) NSInteger attributeLocation;
@property (nonatomic, assign) NSInteger attributeLength;

@end

@implementation TypesetKit

- (void)setString:(NSMutableAttributedString *)string {
    _string = string;
    self.attributeRange = NSMakeRange(0, self.string.length);
    self.attributeFrom = -1;
    self.attributeTo = -1;
    self.attributeLocation = -1;
    self.attributeLength = -1;

}

- (TypesettingIntegerBlock)from {
    return ^(NSUInteger from) {
        if (self.attributeTo != -1) {
            self.attributeRange = NSMakeRange(from, self.attributeTo - from);
        }
        self.attributeFrom = from;
        return self;
    };
}

- (TypesettingIntegerBlock)to {
    return ^(NSUInteger to) {
        if (self.attributeFrom != -1) {
            self.attributeRange = NSMakeRange(self.attributeFrom, to - self.attributeFrom);
        }
        self.attributeTo = to;
        return self;
    };
}

- (TypesettingIntegerBlock)location {
    return ^(NSUInteger location) {
        if (self.attributeLength != -1) {
            self.attributeRange = NSMakeRange(location, self.attributeLength);
        }
        self.attributeLocation = location;
        return self;
    };
}

- (TypesettingIntegerBlock)length {
    return ^(NSUInteger length) {
        if (self.attributeLength != -1) {
            self.attributeRange = NSMakeRange(self.attributeLocation, length);
        }
        self.attributeLength = length;
        return self;
    };
}

- (TypesettingRangeBlock)range {
    return ^(NSRange range) {
        self.attributeRange = range;
        return self;
    };
}

- (TypesettingStringBlock)substring {
    return ^(NSString *substring) {
        NSRange range = [self.string.string rangeOfString:substring];
        self.attributeRange = range;
        return self;
    };
}

- (TypesetKit *)all {
    self.attributeRange = NSMakeRange(0, self.string.length);
    return self;
}

- (TypesettingColorBlock)color {
    return ^(UIColor *color) {
        [self.string addAttribute:NSForegroundColorAttributeName value:color range:self.attributeRange];
        return self;
    };
}

- (TypesettingIntegerBlock)hexColor {
    return ^(NSUInteger hexColor) {
        [self.string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(hexColor) range:self.attributeRange];
        return self;
    };
}

- (TypesettingFontBlock)font {
    return ^(NSString *fontName, CGFloat fontSize) {
        self.fontName(fontName).fontSize(fontSize);
        return self;
    };
}

- (TypesettingStringBlock)fontName {
    return ^(NSString *fontName) {
        NSRange range = self.attributeRange;
        UIFont *font = [self.string attribute:NSFontAttributeName atIndex:0 effectiveRange:&range];
        CGFloat size = font.pointSize;
        [self.string addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:size] range:self.attributeRange];
        return self;
    };
}

- (TypesettingCGFloatBlock)fontSize {
    return ^(CGFloat fontSize) {
        NSRange range = self.attributeRange;
        UIFont *font = [self.string attribute:NSFontAttributeName atIndex:0 effectiveRange:&range];
        font = [font fontWithSize:fontSize];
        if (!font) font = [UIFont systemFontOfSize:fontSize];
        [self.string addAttribute:NSFontAttributeName value:font range:self.attributeRange];
        return self;
    };
}

- (TypesettingIntegerBlock)underline {
    return ^(NSUInteger underline) {
        [self.string addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:underline] range:self.attributeRange];
        return self;
    };
}

- (TypesettingStringBlock)link {
    return ^(NSString *url) {
        [self.string addAttribute:NSLinkAttributeName value:url range:self.attributeRange];
        return self;
    };
}

- (TypesettingStringBlock)append {
    return ^(NSString *string) {
        [self.string appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
        return self;
    };
}

@end
