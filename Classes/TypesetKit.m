//
//  TypesetKit.m
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "TypesetKit.h"
#import "NSValue+Range.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TypesetKit ()

@property (nonatomic, strong) NSMutableArray *attributeRanges;

@property (nonatomic, assign) NSInteger attributeFrom;
@property (nonatomic, assign) NSInteger attributeTo;

@property (nonatomic, assign) NSInteger attributeLocation;
@property (nonatomic, assign) NSInteger attributeLength;

@end

@implementation TypesetKit

- (void)setString:(NSMutableAttributedString *)string {
    _string = string;
    self.attributeRanges = [NSMutableArray arrayWithObject:[NSValue valueWithLocation:0 length:self.string.length]];
    self.attributeFrom = -1;
    self.attributeTo = -1;
    self.attributeLocation = -1;
    self.attributeLength = -1;

}

- (TypesettingIntegerBlock)from {
    return ^(NSUInteger from) {
        if (self.attributeTo != -1) {
            [self.attributeRanges removeAllObjects];
            [self.attributeRanges addObject:[NSValue valueWithLocation:from length:self.attributeTo - from]];
        }
        self.attributeFrom = from;
        return self;
    };
}

- (TypesettingIntegerBlock)to {
    return ^(NSUInteger to) {
        if (self.attributeFrom != -1) {
            [self.attributeRanges removeAllObjects];
            [self.attributeRanges addObject:[NSValue valueWithLocation:self.attributeFrom length:to - self.attributeFrom]];
        }
        self.attributeTo = to;
        return self;
    };
}

- (TypesettingIntegerBlock)location {
    return ^(NSUInteger location) {
        if (self.attributeLength != -1) {
            [self.attributeRanges removeAllObjects];
            [self.attributeRanges addObject:[NSValue valueWithLocation:location length:self.attributeLength]];
        }
        self.attributeLocation = location;
        return self;
    };
}

- (TypesettingIntegerBlock)length {
    return ^(NSUInteger length) {
        if (self.attributeLength != -1) {
            [self.attributeRanges removeAllObjects];
            [self.attributeRanges addObject:[NSValue valueWithLocation:self.attributeLocation length:length]];
        }
        self.attributeLength = length;
        return self;
    };
}

- (TypesettingRangeBlock)range {
    return ^(NSRange range) {
        [self.attributeRanges removeAllObjects];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        return self;
    };
}

- (TypesettingStringBlock)matchAll {
    return ^(NSString *substring) {
        return self.matchAllWithOptions(substring, 0);
    };
}

- (TypesettingMatchBlock)matchAllWithOptions {
    return ^(NSString *substring, NSStringCompareOptions options) {
        NSRange range = [self.string.string rangeOfString:substring options:options];
        [self.attributeRanges removeAllObjects];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        while (range.length != 0) {
            NSInteger location = range.location + range.length;
            NSInteger length = self.string.length - location;
            range = [self.string.string rangeOfString:substring options:options range:NSMakeRange(location, length)];
            [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        }
        return self;
    };
}

- (TypesettingStringBlock)match {
    return ^(NSString *substring) {
        return self.matchWithOptions(substring,0);
    };
}

- (TypesettingMatchBlock)matchWithOptions {
    return ^(NSString *substring, NSStringCompareOptions options) {
        NSRange range = [self.string.string rangeOfString:substring options:options];
        [self.attributeRanges removeAllObjects];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        return self;
    };
}

- (TypesetKit *)all {
    [self.attributeRanges removeAllObjects];
    [self.attributeRanges addObject:[NSValue valueWithLocation:0 length:self.string.length]];
    return self;
}

- (TypesettingColorBlock)color {
    return ^(UIColor *color) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        return self;
    };
}

- (TypesettingIntegerBlock)hexColor {
    return ^(NSUInteger hexColor) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(hexColor) range:range];
        }
        return self;
    };
}

- (TypesettingFontBlock)font {
    return ^(NSString *fontName, CGFloat fontSize) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            UIFont* font = [UIFont fontWithName:fontName
                                           size:fontSize];
            [self.string addAttribute:NSFontAttributeName value:font range:range];
        }
        return self;
    };
}

- (TypesettingStringBlock)fontName {
    return ^(NSString *fontName) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            UIFont *font = [self.string attribute:NSFontAttributeName atIndex:0 effectiveRange:&range];
            range = [value rangeValue];
            CGFloat size = font.pointSize;
            [self.string addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:size] range:range];
        }
        return self;
    };
}

- (TypesettingCGFloatBlock)fontSize {
    return ^(CGFloat fontSize) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            UIFont *font = [self.string attribute:NSFontAttributeName atIndex:0 effectiveRange:&range];
            range = [value rangeValue];
            if (!font) font = [UIFont systemFontOfSize:fontSize];
            [self.string addAttribute:NSFontAttributeName value:font range:range];
        }
        return self;
    };
}

- (TypesettingIntegerBlock)underline {
    return ^(NSUInteger underline) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:underline] range:range];
        }
        return self;
    };
}

- (TypesettingStringBlock)link {
    return ^(NSString *url) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSLinkAttributeName value:url range:range];
        }
        return self;
    };
}

- (TypesettingStringBlock)append {
    return ^(NSString *string) {
        NSMutableAttributedString *mas = [self.string mutableCopy];
        [mas appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
        self.string = mas;
        return self;
    };
}

- (TypesettingIntegerBlock)ligature {
    return ^(NSUInteger ligature) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSLigatureAttributeName value:@(ligature) range:range];
        }
        return self;
    };
}

- (TypesettingIntegerBlock) lineBreakMode {
    return ^(NSUInteger lineBreakMode) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            
            NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
            style.lineBreakMode = lineBreakMode;
            [self.string addAttribute:NSParagraphStyleAttributeName value:style range:range];
        }
        return self;
    };
}

- (TypesettingIntegerBlock)textAlignment {
    return ^(NSUInteger textAlignment) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            
            NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
            style.alignment = textAlignment;
            [self.string addAttribute:NSParagraphStyleAttributeName value:style range:range];
        }
        return self;
    };
}

- (TypesettingCGFloatBlock)lineSpacing {
    return ^(CGFloat lineSpacing) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            
            NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
            style.lineSpacing = lineSpacing;
            [self.string addAttribute:NSParagraphStyleAttributeName value:style range:range];
        }
        return self;
    };
}
@end
