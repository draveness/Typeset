//
//  UITextView+Typeset.h
//  Typeset
//
//  Created by Draveness on 7/24/16.
//  Copyright © 2016 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Typeset)

@property (nonatomic, copy) NSAttributedString *(^typesetBlock)(NSString *string);

@end
