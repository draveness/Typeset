//
//  UITextField+Typeset.h
//  Typeset
//
//  Created by Draveness on 16/4/5.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Typeset)

@property (nonatomic, copy) NSAttributedString *(^typesetBlock)(NSString *string);

@end
