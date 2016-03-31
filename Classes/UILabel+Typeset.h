//
//  UILabel+Typeset.h
//  Typeset
//
//  Created by Draveness on 16/3/31.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Typeset)

@property (nonatomic, copy) NSAttributedString *(^typesetBlock)(NSString *string);

@end
