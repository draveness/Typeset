//
//  UIFont+Weight.m
//  Typeset
//
//  Created by Draveness on 16/3/31.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import "UIFont+Weight.h"

@implementation UIFont (Weight)


- (BOOL)containsFontWeight {
    NSArray<NSString *> *weights = @[@"Thin", @"Bold", @"Italic", @"Light"];
    for (NSString *weight in weights) {
        if ([self.fontName containsString:weight]) {
            return YES;
        }
    }
    return NO;
}

- (TSFontWeight)fontWeight {
    NSArray<NSString *> *weights = self.fontWeightDictionary.allValues;
    __block TSFontWeight fontWeight = TSFontWeightRegular;
    [weights enumerateObjectsUsingBlock:^(NSString * _Nonnull weight, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.fontName containsString:weight]) {
            fontWeight = idx;
            *stop = YES;
        }
    }];
    return fontWeight;
}

- (UIFont *)fontWithFontWeight:(TSFontWeight)weight {
    NSString *name = self.fontName;
    for (NSString *fontWeight in self.fontWeightDictionary.allValues) {
        // STHeitiJ-Regular to STHeitiJ-Thin if weight == TSFontWeightLight
        name = [name stringByReplacingOccurrencesOfString:fontWeight withString:self.fontWeightDictionary[@(weight)]];
    }

    BOOL containWeight = NO;
    for (NSString *fontWeight in self.fontWeightDictionary.allValues) {
        if ([name containsString:fontWeight]) {
            containWeight = YES;
            break;
        }
    }

    if ([self fontWeight] == TSFontWeightRegular && !containWeight) {
        // STHeitiJ to STHeitiJ-Thin if weight == TSFontWeightLight
        name = [name stringByAppendingFormat:@"-%@", self.fontWeightDictionary[@(weight)]];
    }

    if (weight == TSFontWeightRegular) {
        // STHeitiJ-Thin to STHeitiJ if weight == TSFontWeightRegular
        for (NSString *fontWeight in self.fontWeightDictionary.allValues) {
            name = [name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"-%@", fontWeight] withString:@""];
        }

        // if STHeitiJ not exist, append -Regular
        UIFont *regularFont = [UIFont fontWithName:name size:self.pointSize];
        if (!regularFont) {
            name = [name stringByAppendingString:@"-Regular"];
        }
    }

    UIFont *result = [UIFont fontWithName:name size:self.pointSize];

    return result ? result : self;
}

- (NSDictionary<NSNumber *, NSString *> *)fontWeightDictionary {
    return @{
             @(TSFontWeightRegular): @"Regular",
             @(TSFontWeightThin): @"Thin",
             @(TSFontWeightLight): @"Light",
             @(TSFontWeightItalic): @"Italic",
             @(TSFontWeightBold): @"Bold"
             };
}

@end
