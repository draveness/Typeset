//
//  TypesetKit.h
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypesetKit : NSObject

typedef NS_ENUM(NSInteger, TSUnderline) {
    TSUnderlineNoUnder = NSUnderlineStyleNone,
    TSUnderlineSingle = NSUnderlineStyleSingle,
    TSUnderlineThick = NSUnderlineStyleThick,
    TSUnderlineDouble = NSUnderlineStyleDouble,
    TSUnderlinePatternSolid = NSUnderlinePatternSolid,
    TSUnderlinePatternDot = NSUnderlinePatternDot,
    TSUnderlinePatternDash = NSUnderlinePatternDash,
    TSUnderlinePatternDashDot = NSUnderlinePatternDashDot,
    TSUnderlinePatternDotDot = NSUnderlinePatternDashDotDot,
    TSUnderlineByWord = NSUnderlineByWord
};

// TSStrikeThrough is just a copy of TSUnderline
typedef TSUnderline TSStrikeThrough;

typedef TypesetKit *(^TypesettingIntegerBlock)(NSUInteger);
typedef TypesetKit *(^TypesettingCGFloatBlock)(CGFloat);
typedef TypesetKit *(^TypesettingRangeBlock)(NSRange);
typedef TypesetKit *(^TypesettingStringBlock)(NSString *);
typedef TypesetKit *(^TypesettingColorBlock)(UIColor *);
typedef TypesetKit *(^TypesettingBaselineBlock)(CGFloat);
typedef TypesetKit *(^TypesettingStrikeThroughBlock)(TSStrikeThrough);
typedef TypesetKit *(^TypesettingFontBlock)(NSString *, CGFloat);
typedef TypesetKit *(^TypesettingMatchBlock)(NSString *, NSStringCompareOptions);
typedef TypesetKit *(^TypesettingShadowBlock)(NSShadow *);

@property (nonatomic, strong) NSMutableAttributedString *string;

- (TypesettingIntegerBlock)from;
- (TypesettingIntegerBlock)to;
- (TypesettingIntegerBlock)location;
- (TypesettingIntegerBlock)length;
- (TypesettingRangeBlock)range;
- (TypesettingStringBlock)match;
- (TypesettingMatchBlock)matchWithOptions;
- (TypesettingStringBlock)matchAll;
- (TypesettingMatchBlock)matchAllWithOptions;
- (TypesetKit *)all;

- (TypesettingColorBlock)color;
- (TypesettingIntegerBlock)hexColor;

- (TypesettingStringBlock)fontName;
- (TypesettingCGFloatBlock)fontSize;
- (TypesettingFontBlock)font;
- (TypesetKit *)regular;
- (TypesetKit *)light;
- (TypesetKit *)bold;
- (TypesetKit *)italic;
- (TypesetKit *)thin;

- (TypesettingStrikeThroughBlock)strikeThrough;

- (TypesettingBaselineBlock)baseline;

- (TypesettingIntegerBlock)underline;

- (TypesettingStringBlock)link;

- (TypesettingStringBlock)append;

- (TypesettingIntegerBlock)ligature;

- (TypesettingCGFloatBlock)kern;

- (TypesettingColorBlock)strokeColor;

- (TypesettingCGFloatBlock)strokeWidth;

- (TypesettingShadowBlock)shadow;

- (TypesettingStringBlock)textEffect;

// NSMutableParagraphStyle
- (TypesettingIntegerBlock)lineBreakMode;
- (TypesettingIntegerBlock)textAlignment;
- (TypesettingCGFloatBlock)lineSpacing;

@end
