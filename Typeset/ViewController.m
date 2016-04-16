//
//  ViewController.m
//  Typeset
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "ViewController.h"
#import "Typeset.h"


@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.typesetBlock = TSBlock(matchAll(@"NSAttributedString").fontSize(30).blue.
                                 match(@"efficiently").bold);

    label.text = @"Deal with NSAttributedString efficiently.";
    label.frame = CGRectMake(0, 0, 300, 200);
//    [label sizeToFit];
    [self.view addSubview:label];
    label.center = self.view.center;
    label.numberOfLines = 0;

    label.textAlignment = NSTextAlignmentCenter;
//    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y / 2, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:textfield];
//    textfield.typesetBlock = TSBlock(matchAll(@"1").red);
//
//    textfield.delegate = self;

//    // You can keep adding typeset styles to the same attributed string.
//    NSMutableAttributedString *baselineTest =  @"This is a strikethrough test.".typeset.match(@"This").underline(1).match(@"is a").baseline(5).match(@"strikethrough").strikeThrough(TSSingle).match(@"test").strikeThrough(TSDouble).string;

    UILabel *prompt = [[UILabel alloc] init];
    prompt.attributedText = @"String below is created with: \n\n@\"Deal with NSAttributedString efficiently\".typeset.\nmatchAll(@\"NSAttributedString\").fontSize(30).blue.\nmatch(@\"efficiently\").bold.string)".typeset.fontSize(14.5).match(@"String below is created with:").fontSize(20).string;
    [self.view addSubview:prompt];
    prompt.frame = CGRectMake(0, 0, 350, 300);
//    [prompt sizeToFit];
    prompt.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    prompt.numberOfLines = 0;

}

@end
