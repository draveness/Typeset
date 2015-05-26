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
typedef TypesetKit *(^TypesettingFontBlock)(NSString *, CGFloat);

@property (nonatomic, strong) NSMutableAttributedString *string;

- (TypesettingIntegerBlock)from;
- (TypesettingIntegerBlock)to;
- (TypesettingIntegerBlock)location;
- (TypesettingIntegerBlock)length;
- (TypesettingRangeBlock)range;
- (TypesettingStringBlock)substring;
- (TypesetKit *)all;

- (TypesettingColorBlock)color;
- (TypesettingIntegerBlock)hexColor;

- (TypesettingStringBlock)fontName;
- (TypesettingCGFloatBlock)fontSize;
- (TypesettingFontBlock)font;

- (TypesettingIntegerBlock)underline;

- (TypesettingStringBlock)link;

- (TypesettingStringBlock)append;

@end
