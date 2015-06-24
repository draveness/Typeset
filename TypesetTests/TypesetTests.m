//
//  TypesetTests.m
//  TypesetTests
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Typeset.h"
@interface TypesetTests : XCTestCase

@end

@implementation TypesetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


- (void)testSelfEqual {
    
    NSString *txt = @"Hello typeset";
    
    NSMutableAttributedString *attributedTxt1 = txt.typeset.matchAll(@"o").red.string;
    
    NSMutableAttributedString *attributedTxt2 = txt.typeset.matchAll(@"l").red.string;
    
    XCTAssertFalse([attributedTxt1 isEqualToAttributedString:attributedTxt2]);
    
    NSMutableAttributedString *attributedTxt3 = txt.typeset.matchAll(@"o").red.string;
    
    XCTAssertTrue([attributedTxt1 isEqualToAttributedString:attributedTxt3]);
    
}

- (void)testEqual {
    
    NSDictionary *obj1 = @{@"abc":@"Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset "};
    
    NSDictionary *tmpObj = @{@"def":@"Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset Hello typeset "};
    NSDictionary *obj2 = [[NSDictionary alloc] initWithDictionary:tmpObj];
    
    NSString *txt = obj1[@"abc"];
    NSString *txt2 = [obj2[@"def"] copy]; // no difference, just to demonstrate the optimization of NSString done by Apple
    
//    XCTAssertFalse([txt isEqual:txt2]);
    
    //attributedString from txt1
    NSMutableAttributedString *attributedTxt1 = txt.typeset.matchAll(@"o").red.string;
    
    //attributedString from txt2
    NSMutableAttributedString *attributedTxt2_1 = txt2.typeset.matchAll(@"o").red.string;
    XCTAssertTrue([attributedTxt1 isEqualToAttributedString:attributedTxt2_1]);
    
    NSMutableAttributedString *attributedTxt2_2 = txt2.typeset.matchAll(@"l").red.string;
    XCTAssertFalse([attributedTxt1 isEqualToAttributedString:attributedTxt2_2]);
    
    NSMutableAttributedString *attributedTxt2_3 = txt2.typeset.matchAll(@"o").red.string;
    XCTAssertTrue([attributedTxt1 isEqualToAttributedString:attributedTxt2_3]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
