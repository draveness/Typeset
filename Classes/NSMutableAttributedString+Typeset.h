//
//  NSMutableAttributedString+Typeset.h
//  Typeset
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TypesetKit;

@interface NSMutableAttributedString (Typeset)

- (TypesetKit *)typeset;

- (NSMutableAttributedString *(^)(id))append;

- (NSMutableAttributedString *(^)(UIColor *))color;
- (NSMutableAttributedString *(^)(NSUInteger))hexColor;
- (NSMutableAttributedString *(^)(NSUInteger))fontSize;
- (NSMutableAttributedString *(^)(NSString *))fontName;
- (NSMutableAttributedString *(^)(NSString *, CGFloat))font;


@end
