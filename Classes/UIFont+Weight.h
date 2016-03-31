//
//  UIFont+Weight.h
//  Typeset
//
//  Created by Draveness on 16/3/31.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TSFontWeight) {
    TSFontWeightRegular,
    TSFontWeightThin,
    TSFontWeightBold,
    TSFontWeightItalic,
    TSFontWeightLight
};

@interface UIFont (Weight)

- (UIFont *)fontWithFontWeight:(TSFontWeight)weight;

@end
