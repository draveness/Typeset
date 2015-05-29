//
//  NSValue+Range.h
//  Typeset
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValue (Range)

+ (NSValue *)valueWithLocation:(NSUInteger)location length:(NSUInteger)length;

@end
