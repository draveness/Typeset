//
//  TypesetKit+Match.m
//  Typeset
//
//  Created by Draveness on 16/4/18.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import "TypesetKit+Match.h"
#import "NSValue+Range.h"

@interface TypesetKit ()

@property (nonatomic, strong) NSMutableArray *attributeRanges;

@property (nonatomic, assign) NSInteger attributeFrom;
@property (nonatomic, assign) NSInteger attributeTo;

@property (nonatomic, assign) NSInteger attributeLocation;
@property (nonatomic, assign) NSInteger attributeLength;

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@end

@implementation TypesetKit (Match)

- (void)removeAllAttributeRanges {
    [self.attributeRanges removeAllObjects];
    self.paragraphStyle = nil;
}

- (TypesetUIntegerBlock)from {
    return ^(NSUInteger from) {
        if (self.attributeTo != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:from length:self.attributeTo - from]];
        }
        self.attributeFrom = from;
        return self;
    };
}

- (TypesetUIntegerBlock)to {
    return ^(NSUInteger to) {
        if (self.attributeFrom != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:self.attributeFrom length:to - self.attributeFrom]];
        }
        self.attributeTo = to;
        return self;
    };
}

- (TypesetUIntegerBlock)location {
    return ^(NSUInteger location) {
        if (self.attributeLength != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:location length:self.attributeLength]];
        }
        self.attributeLocation = location;
        return self;
    };
}

- (TypesetUIntegerBlock)length {
    return ^(NSUInteger length) {
        if (self.attributeLocation != -1) {
            [self removeAllAttributeRanges];
            [self.attributeRanges addObject:[NSValue valueWithLocation:self.attributeLocation length:length]];
        }
        self.attributeLength = length;
        return self;
    };
}

- (TypesetRangeBlock)range {
    return ^(NSRange range) {
        [self removeAllAttributeRanges];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        return self;
    };
}

- (TypesetStringBlock)matchAll {
    return ^(NSString *substring) {
        return self.matchAllWithOptions(substring, 0);
    };
}

- (TypesetMatchBlock)matchAllWithOptions {
    return ^(NSString *substring, NSStringCompareOptions options) {
        NSRange range = [self.string.string rangeOfString:substring options:options];
        [self removeAllAttributeRanges];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        while (range.length != 0) {
            NSInteger location = range.location + range.length;
            NSInteger length = self.string.length - location;
            range = [self.string.string rangeOfString:substring options:options range:NSMakeRange(location, length)];
            [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        }
        return self;
    };
}

- (TypesetStringBlock)match {
    return ^(NSString *substring) {
        return self.matchWithOptions(substring,0);
    };
}

- (TypesetMatchBlock)matchWithOptions {
    return ^(NSString *substring, NSStringCompareOptions options) {
        NSRange range = [self.string.string rangeOfString:substring options:options];
        [self removeAllAttributeRanges];
        [self.attributeRanges addObject:[NSValue valueWithRange:range]];
        return self;
    };
}

- (TypesetKit *)all {
    [self removeAllAttributeRanges];
    [self.attributeRanges addObject:[NSValue valueWithLocation:0 length:self.string.length]];
    return self;
}

@end
