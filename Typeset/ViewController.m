//
//  ViewController.m
//  Typeset
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "ViewController.h"
#import "Typeset.h"

#define <#macro#>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    [self.view addSubview:label];
    label.numberOfLines = 0;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *mas = @"Hello typeset, hello.".typeset.matchAll(@"Hello").fontSize(40)
        .match(@"type").purple
        .match(@"set").blue
        .string;
    
    // You can keep adding typeset styles to the same attributed string.
    NSMutableAttributedString *baselineTest =  @"This is a strikethrough test.".typeset.match(@"This").underline(1).match(@"is a").baseline(5).match(@"strikethrough").strikeThrough(TSSingle).match(@"test").strikeThrough(TSDouble).string;

    label.attributedText = mas.append(baselineTest);
}

@end
