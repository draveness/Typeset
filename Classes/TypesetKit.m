//
//  TypesetKit.m
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "TypesetKit.h"
#import "NSValue+Range.h"
#import "UIFont+Weight.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TypesetKit ()

@property (nonatomic, strong) NSMutableArray *attributeRanges;

@property (nonatomic, assign) NSInteger attributeFrom;
@property (nonatomic, assign) NSInteger attributeTo;

@property (nonatomic, assign) NSInteger attributeLocation;
@property (nonatomic, assign) NSInteger attributeLength;

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@end

@implementation TypesetKit

- (void)removeAllAttributeRanges {
    [self.attributeRanges removeAllObjects];
    self.paragraphStyle = nil;
}

- (void)setString:(NSMutableAttributedString *)string {
    _string = string;
    self.attributeRanges = [NSMutableArray arrayWithObject:[NSValue valueWithLocation:0 length:self.string.length]];
    self.attributeFrom = -1;
    self.attributeTo = -1;
    self.attributeLocation = -1;
    self.attributeLength = -1;

}

- (TypesetUIntegerBlock)from {
    return ^(NSUInteger from) {
        if (self.attributeTo != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:from length:self.attributeTo - from]];
        }
        self.attributeFrom = from;
        return self;
    };
}

- (TypesetUIntegerBlock)to {
    return ^(NSUInteger to) {
        if (self.attributeFrom != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:self.attributeFrom length:to - self.attributeFrom]];
        }
        self.attributeTo = to;
        return self;
    };
}

- (TypesetUIntegerBlock)location {
    return ^(NSUInteger location) {
        if (self.attributeLength != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:location length:self.attributeLength]];
        }
        self.attributeLocation = location;
        return self;
    };
}

- (TypesetUIntegerBlock)length {
    return ^(NSUInteger length) {
        if (self.attributeLocation != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:self.attributeLocation length:length]];
        }
        self.attributeLength = length;
        return self;
    };
}

- (TypesetRangeBlock)range {
    return ^(NSRange range) {
        [self removeAllAttributeRanges];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        return self;
    };
}

- (TypesetStringBlock)matchAll {
    return ^(NSString *substring) {
        return self.matchAllWithOptions(substring, 0);
    };
}

- (TypesetMatchBlock)matchAllWithOptions {
    return ^(NSString *substring, NSStringCompareOptions options) {
        NSRange range = [self.string.string rangeOfString:substring options:options];
        [self removeAllAttributeRanges];
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

- (TypesetStringBlock)match {
    return ^(NSString *substring) {
        return self.matchWithOptions(substring,0);
    };
}

- (TypesetMatchBlock)matchWithOptions {
    return ^(NSString *substring, NSStringCompareOptions options) {
        NSRange range = [self.string.string rangeOfString:substring options:options];
        [self removeAllAttributeRanges];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        return self;
    };
}

- (TypesetKit *)all {
    [self removeAllAttributeRanges];
    [self.attributeRanges addObject:[NSValue valueWithLocation:0 length:self.string.length]];
    return self;
}

- (TypesetColorBlock)color {
    return ^(UIColor *color) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        return self;
    };
}

- (TypesetUIntegerBlock)hexColor {
    return ^(NSUInteger hexColor) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(hexColor) range:range];
        }
        return self;
    };
}

- (TypesetCGFloatBlock)baseline {
    return ^(CGFloat baseline) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSBaselineOffsetAttributeName value:@(baseline) range:range];
        }
        return self;
    };
}

- (TypesetBlock(NSUnderlineStyle))strikeThrough {
    return ^(NSUnderlineStyle strikeThroughStyle) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSStrikethroughStyleAttributeName value:@(strikeThroughStyle) range:range];
        }
        return self;
    };
}

- (TypesetColorBlock)strikeThroughColor {
    return ^(UIColor *strikeThroughColor) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSStrikethroughColorAttributeName value:strikeThroughColor range:range];
        }
        return self;
    };
}

- (TypesetFontBlock)font {
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

- (TypesetStringBlock)fontName {
    return ^(NSString *fontName) {
        if (self.string.length) {
            for (NSValue *value in self.attributeRanges) {
                NSRange range = [value rangeValue];
                UIFont *font = [self.string attribute:NSFontAttributeName atIndex:0 effectiveRange:&range];
                range = [value rangeValue];
                CGFloat size = font.pointSize;
                [self.string addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:size] range:range];
            }
        }
        
        return self;
    };
}

- (TypesetKit *)changeFontWeight:(TSFontWeight)fontWeight {
    if (self.string.length) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            UIFont *font = [self.string attribute:NSFontAttributeName atIndex:0 effectiveRange:&range];
            range = [value rangeValue];

            if (!font) {
                font = [UIFont systemFontOfSize:17];
            }
            font = [font fontWithFontWeight:fontWeight];
            [self.string addAttribute:NSFontAttributeName value:font range:range];
        }
    }
    return self;
}

- (TypesetKit *)regular {
    return [self changeFontWeight:TSFontWeightRegular];
}

- (TypesetKit *)light {
    return [self changeFontWeight:TSFontWeightLight];
}

- (TypesetKit *)bold {
    return [self changeFontWeight:TSFontWeightBold];
}

- (TypesetKit *)italic {
    return [self changeFontWeight:TSFontWeightItalic];
}

- (TypesetKit *)thin {
    return [self changeFontWeight:TSFontWeightThin];
}

- (TypesetCGFloatBlock)fontSize {
    return ^(CGFloat fontSize) {
        if (self.string.length) {
            for (NSValue *value in self.attributeRanges) {
                NSRange range = [value rangeValue];
                UIFont *font = [self.string attribute:NSFontAttributeName atIndex:0 effectiveRange:&range];
                range = [value rangeValue];
                if (!font) {
                    font = [UIFont systemFontOfSize:17];
                }
                font = [UIFont systemFontOfSize:fontSize];
                [self.string addAttribute:NSFontAttributeName value:font range:range];
            }
        }
        
        return self;
    };
}

- (TypesetBlock(NSUnderlineStyle))underline {
    return ^(NSUnderlineStyle underline) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:underline] range:range];
        }
        return self;
    };
}

- (TypesetColorBlock)underlineColor {
    return ^(UIColor *underlineColor) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSUnderlineColorAttributeName value:underlineColor range:range];
        }
        return self;
    };
}

- (TypesetStringBlock)link {
    return ^(NSString *url) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSLinkAttributeName value:url range:range];
        }
        return self;
    };
}

- (TypesetStringBlock)append {
    return ^(NSString *string) {
        NSMutableAttributedString *mas = [self.string mutableCopy];
        [mas appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
        self.string = mas;
        return self;
    };
}

- (TypesetUIntegerBlock)ligature {
    return ^(NSUInteger ligature) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            [self.string addAttribute:NSLigatureAttributeName value:@(ligature) range:range];
        }
        return self;
    };
}

- (TypesetCGFloatBlock)kern {
    return ^(CGFloat kern) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSKernAttributeName value:@(kern) range:range];
        }
        return self;
    };
}


- (TypesetColorBlock)strokeColor {
    return ^(UIColor *strokeColor) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
        }
        return self;
    };
}

- (TypesetCGFloatBlock)strokeWidth {
    return ^(CGFloat strokeWidth) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSStrokeWidthAttributeName value:@(strokeWidth) range:range];
        }
        return self;
    };
}

- (TypesetBlock(NSShadow *))shadow {
    return ^(NSShadow *shadow) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSShadowAttributeName value:shadow range:range];
        }
        return self;
    };
}

- (TypesetStringBlock)textEffect {
    return ^(NSString *textEffect) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSTextEffectAttributeName value:textEffect range:range];
        }
        return self;
    };
}

- (TypesetCGFloatBlock)obliqueness {
    return ^(CGFloat obliqueness) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSObliquenessAttributeName value:@(obliqueness) range:range];
        }
        return self;
    };
}

- (TypesetCGFloatBlock)expansion {
    return ^(CGFloat expansion) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSExpansionAttributeName value:@(expansion) range:range];
        }
        return self;
    };
}

- (TypesetBlock(NSTextAttachment *))textAttachment {
    return ^(NSTextAttachment *textAttachment) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];

            [self.string addAttribute:NSAttachmentAttributeName value:textAttachment range:range];
        }
        return self;
    };
}

#pragma mark - NSParagraphStyle

- (TypesetBlock(NSLineBreakMode))lineBreakMode {
    return ^(NSLineBreakMode lineBreakMode) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            
            self.paragraphStyle.lineBreakMode = lineBreakMode;
            [self.string addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:range];
        }
        return self;
    };
}

- (TypesetBlock(NSTextAlignment))textAlignment {
    return ^(NSTextAlignment textAlignment) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            
            self.paragraphStyle.alignment = textAlignment;
            [self.string addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:range];
        }
        return self;
    };
}

- (TypesetCGFloatBlock)lineSpacing {
    return ^(CGFloat lineSpacing) {
        for (NSValue *value in self.attributeRanges) {
            NSRange range = [value rangeValue];
            
            self.paragraphStyle.lineSpacing = lineSpacing;
            [self.string addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:range];
        }
        return self;
    };
}

- (NSMutableParagraphStyle *)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    return _paragraphStyle;
}

@end
