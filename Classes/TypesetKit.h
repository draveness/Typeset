//
//  TypesetKit.h
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Typeset($string) ( $string ? $string.typeset : @"".typeset )

#define TypesetBlock(...) TypesetKit *(^)(__VA_ARGS__)

#define TypesetUIntegerBlock TypesetBlock(NSUInteger)
#define TypesetIntegerBlock TypesetBlock(NSInteger)
#define TypesetCGFloatBlock TypesetBlock(CGFloat)
#define TypesetRangeBlock TypesetBlock(NSRange)
#define TypesetStringBlock TypesetBlock(NSString *)
#define TypesetObjectBlock TypesetBlock(id)
#define TypesetColorBlock TypesetBlock(UIColor *)
#define TypesetFontBlock TypesetBlock(NSString *, CGFloat)
#define TypesetMatchBlock TypesetBlock(NSString *, NSStringCompareOptions)
#define TSString($a, ...) 


@interface TypesetKit : NSObject

@property (nonatomic, strong) NSMutableAttributedString *string;

- (TypesetColorBlock)color;
- (TypesetUIntegerBlock)hexColor;

- (TypesetStringBlock)fontName;
- (TypesetCGFloatBlock)fontSize;
- (TypesetFontBlock)font;
- (TypesetKit *)regular;
- (TypesetKit *)light;
- (TypesetKit *)bold;
- (TypesetKit *)italic;
- (TypesetKit *)thin;

- (TypesetBlock(NSUnderlineStyle))strikeThrough;

- (TypesetColorBlock)strikeThroughColor;

- (TypesetCGFloatBlock)baseline;

- (TypesetBlock(NSUnderlineStyle))underline;

- (TypesetColorBlock)underlineColor;

- (TypesetStringBlock)link;

- (TypesetObjectBlock)append;

- (TypesetUIntegerBlock)ligature;

- (TypesetCGFloatBlock)kern;

- (TypesetColorBlock)strokeColor;

- (TypesetCGFloatBlock)strokeWidth;

- (TypesetBlock(NSShadow *))shadow;

- (TypesetStringBlock)textEffect;

- (TypesetCGFloatBlock)obliqueness;

- (TypesetCGFloatBlock)expansion;

// NSMutableParagraphStyle
- (TypesetBlock(NSLineBreakMode))lineBreakMode;
- (TypesetBlock(NSTextAlignment))alignment;
- (TypesetBlock(NSTextAlignment))textAlignment;
- (TypesetCGFloatBlock)lineSpacing;
- (TypesetCGFloatBlock)paragraphSpacing;
- (TypesetCGFloatBlock)headIndent;
- (TypesetCGFloatBlock)tailIndent;
- (TypesetCGFloatBlock)minimumLineHeight;
- (TypesetCGFloatBlock)maximumLineHeight;
- (TypesetCGFloatBlock)lineHeightMultiple;
- (TypesetCGFloatBlock)paragraphSpacingBefore;
- (TypesetCGFloatBlock)hyphenationFactor;
- (TypesetCGFloatBlock)defaultTabInterval;
- (TypesetBlock(NSWritingDirection))baseWritingDirection;
- (TypesetBlock(BOOL))allowsDefaultTighteningForTruncation;

@end
