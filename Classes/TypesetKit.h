//
//  TypesetKit.h
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TypesetBlock(...) TypesetKit *(^)(__VA_ARGS__)

#define TypesetUIntegerBlock TypesetBlock(NSUInteger)
#define TypesetIntegerBlock TypesetBlock(NSInteger)
#define TypesetCGFloatBlock TypesetBlock(CGFloat)
#define TypesetRangeBlock TypesetBlock(NSRange)
#define TypesetStringBlock TypesetBlock(NSString *)
#define TypesetColorBlock TypesetBlock(UIColor *)
#define TypesetFontBlock TypesetBlock(NSString *, CGFloat)
#define TypesetMatchBlock TypesetBlock(NSString *, NSStringCompareOptions)


@interface TypesetKit : NSObject

@property (nonatomic, strong) NSMutableAttributedString *string;

- (TypesetUIntegerBlock)from;
- (TypesetUIntegerBlock)to;
- (TypesetUIntegerBlock)location;
- (TypesetUIntegerBlock)length;
- (TypesetRangeBlock)range;
- (TypesetStringBlock)match;
- (TypesetMatchBlock)matchWithOptions;
- (TypesetStringBlock)matchAll;
- (TypesetMatchBlock)matchAllWithOptions;
- (TypesetKit *)all;

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

- (TypesetStringBlock)append;

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

@end
