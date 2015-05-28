//
//  ViewController.m
//  Typeset
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "ViewController.h"
#import "Typeset.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    [self.view addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *mas = @"Hello typeset".typeset.match(@"Hello").fontSize(40)
        .match(@"type").red
        .match(@"set").green
        .underline(NSUnderlineStyleSingle).append(@"He").string;
    label.attributedText = mas;
}

@end
