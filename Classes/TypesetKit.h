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
    TSNoUnder = NSUnderlineStyleNone,
    TSSingle = NSUnderlineStyleSingle,
    TSThick = NSUnderlineStyleThick,
    TSDouble = NSUnderlineStyleDouble,
    TSPatternSolid = NSUnderlinePatternSolid,
    TSPatternDot = NSUnderlinePatternDot,
    TSPatternDash = NSUnderlinePatternDash,
    TSPatternDashDot = NSUnderlinePatternDashDot,
    TSPatternDotDot = NSUnderlinePatternDashDotDot,
    TSByWord = NSUnderlineByWord
};

// TSStrikeThrough is just a copy of TSUnderline
typedef TSUnderline TSStrikeThrough;

typedef TypesetKit *(^TypesettingIntegerBlock)(NSUInteger);
typedef TypesetKit *(^TypesettingCGFloatBlock)(CGFloat);
typedef TypesetKit *(^TypesettingRangeBlock)(NSRange);
typedef TypesetKit *(^TypesettingStringBlock)(NSString *);
typedef TypesetKit *(^TypesettingColorBlock)(UIColor *);
typedef TypesetKit *(^TypesettingBaselineBlock)(NSInteger);
typedef TypesetKit *(^TypesettingStrikeThroughBlock)(TSStrikeThrough);
typedef TypesetKit *(^TypesettingFontBlock)(NSString *, CGFloat);
typedef TypesetKit *(^TypesettingMatchBlock)(NSString *,NSStringCompareOptions);

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

- (TypesettingStrikeThroughBlock)strikeThrough;

- (TypesettingBaselineBlock)baseline;

- (TypesettingIntegerBlock)underline;

- (TypesettingStringBlock)link;

- (TypesettingStringBlock)append;

- (TypesettingIntegerBlock)ligature;

- (TypesettingCGFloatBlock)kern;

- (TypesettingIntegerBlock)lineBreakMode;

- (TypesettingIntegerBlock)textAlignment;

- (TypesettingCGFloatBlock)lineSpacing;

@end
