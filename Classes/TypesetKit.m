//
//  TypesetKit.m
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "TypesetKit.h"
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

NSMutableAttributedString *_TSAttributedString(int size, ...) {
    va_list vl;
    va_start(vl, size);
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    for (NSUInteger i = 0; i < size; i++) {
        id string = va_arg(vl, id);
        NSMutableAttributedString *mas = [TypesetKit convertToMutableAttributedString:string];
        [result appendAttributedString:mas];
    }
    return result;
}

- (void)setString:(NSMutableAttributedString *)string {
    _string = string;

    self.attributeRanges = [NSMutableArray arrayWithObject:[NSValue valueWithRange:NSMakeRange(0, self.string.length)]];
    self.attributeFrom = -1;
    self.attributeTo = -1;
    self.attributeLocation = -1;
    self.attributeLength = -1;

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

- (TypesetObjectBlock)append {
    return ^(id string) {
        if (!string) return self;

        NSMutableAttributedString *mas = [TypesetKit convertToMutableAttributedString:string];

        [self.string appendAttributedString:mas];
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

#define NSParagraphStyleReturnBlock(type, attribute) \
    ^(type attribute) { \
        for (NSValue *value in self.attributeRanges) { \
            NSRange range = [value rangeValue]; \
        \
            self.paragraphStyle.attribute = attribute; \
            [self.string addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:range]; \
        } \
        return self; \
    }

- (TypesetBlock(NSLineBreakMode))lineBreakMode {
    return NSParagraphStyleReturnBlock(NSLineBreakMode, lineBreakMode);
}

- (TypesetBlock(NSTextAlignment))alignment {
    return NSParagraphStyleReturnBlock(NSTextAlignment, alignment);
}

- (TypesetBlock(NSTextAlignment))textAlignment {
    return self.alignment;
}

- (TypesetCGFloatBlock)lineSpacing {
    return NSParagraphStyleReturnBlock(CGFloat, lineSpacing);
}

- (TypesetCGFloatBlock)paragraphSpacing {
    return NSParagraphStyleReturnBlock(CGFloat, paragraphSpacing);
}

- (TypesetCGFloatBlock)headIndent {
    return NSParagraphStyleReturnBlock(CGFloat, headIndent);
}

- (TypesetCGFloatBlock)tailIndent {
    return NSParagraphStyleReturnBlock(CGFloat, tailIndent);
}

- (TypesetCGFloatBlock)minimumLineHeight {
    return NSParagraphStyleReturnBlock(CGFloat, minimumLineHeight);
}

- (TypesetCGFloatBlock)maximumLineHeight {
    return NSParagraphStyleReturnBlock(CGFloat, maximumLineHeight);
}

- (TypesetCGFloatBlock)lineHeightMultiple {
    return NSParagraphStyleReturnBlock(CGFloat, lineHeightMultiple);
}

- (TypesetCGFloatBlock)paragraphSpacingBefore {
    return NSParagraphStyleReturnBlock(CGFloat, paragraphSpacingBefore);
}

- (TypesetCGFloatBlock)hyphenationFactor {
    return NSParagraphStyleReturnBlock(CGFloat, hyphenationFactor);
}

- (TypesetCGFloatBlock)defaultTabInterval {
    return NSParagraphStyleReturnBlock(CGFloat, defaultTabInterval);
}

- (TypesetBlock(NSWritingDirection))baseWritingDirection {
    return NSParagraphStyleReturnBlock(NSWritingDirection, baseWritingDirection);
}

- (TypesetBlock(BOOL))allowsDefaultTighteningForTruncation {
    return NSParagraphStyleReturnBlock(BOOL, allowsDefaultTighteningForTruncation);
}

- (NSMutableParagraphStyle *)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    return _paragraphStyle;
}

+ (NSMutableAttributedString *)convertToMutableAttributedString:(id)string {
    NSAssert([string isKindOfClass:[NSString class]] ||
             [string isKindOfClass:[NSAttributedString class]] ||
             [string isKindOfClass:[NSMutableAttributedString class]], @"String passed into this method should be NSString，NSAttributedString or NSMutableAttributedString.");
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
    if ([string isKindOfClass:[NSString class]]) {
        mas = [[NSMutableAttributedString alloc] initWithString:string];
    } else if ([string isKindOfClass:[NSAttributedString class]]) {
        mas = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    } else {
        mas = (NSMutableAttributedString *)string;
    }
    return mas;
}

- (void)restoreParagraphStyle {
    
    _paragraphStyle = nil;
}

@end
