//
//  TypesetKit.h
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypesetKit : NSObject

typedef TypesetKit *(^TypesettingIntegerBlock)(NSUInteger);
typedef TypesetKit *(^TypesettingCGFloatBlock)(CGFloat);
typedef TypesetKit *(^TypesettingRangeBlock)(NSRange);
typedef TypesetKit *(^TypesettingStringBlock)(NSString *);
typedef TypesetKit *(^TypesettingColorBlock)(UIColor *);
typedef TypesetKit *(^TypesettingBaselineBlock)(int);
typedef TypesetKit *(^TypesettingStrikeThroughBlock)(int);
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

- (TypesettingStrikeThroughBlock)strikeThrough;

- (TypesettingFontBlock)font;
- (TypesettingBaselineBlock)baseline;

- (TypesettingIntegerBlock)underline;

- (TypesettingStringBlock)link;

- (TypesettingStringBlock)append;

- (TypesettingIntegerBlock)ligature;

- (TypesettingIntegerBlock)lineBreakMode;

- (TypesettingIntegerBlock)textAlignment;

- (TypesettingCGFloatBlock)lineSpacing;
@end
