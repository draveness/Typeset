//
//  NSValue+Range.m
//  Typeset
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "NSValue+Range.h"

@implementation NSValue (Range)

+ (NSValue *)valueWithLocation:(NSUInteger)location length:(NSUInteger)length {
    return [NSValue valueWithRange:NSMakeRange(location, length)];
}

@end
