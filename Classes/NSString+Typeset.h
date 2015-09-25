//
//  NSString+Typeset.h
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TypesetKit;

#define Typeset(__X__) (__X__?__X__.typeset:@"".typeset)

@interface NSString (Typeset)

- (TypesetKit *)typeset;

- (NSMutableAttributedString *)black;
- (NSMutableAttributedString *)darkGray;
- (NSMutableAttributedString *)lightGray;
- (NSMutableAttributedString *)white;
- (NSMutableAttributedString *)gray;
- (NSMutableAttributedString *)red;
- (NSMutableAttributedString *)green;
- (NSMutableAttributedString *)blue;
- (NSMutableAttributedString *)cyan;
- (NSMutableAttributedString *)yellow;
- (NSMutableAttributedString *)magenta;
- (NSMutableAttributedString *)orange;
- (NSMutableAttributedString *)purple;
- (NSMutableAttributedString *)brown;
- (NSMutableAttributedString *)clear;

- (NSMutableAttributedString *(^)(UIColor *))color;
- (NSMutableAttributedString *(^)(NSUInteger))hexColor;

@end
