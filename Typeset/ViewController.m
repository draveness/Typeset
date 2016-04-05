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
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    [self.view addSubview:label];
    label.numberOfLines = 0;

    label.textAlignment = NSTextAlignmentCenter;
    label.typesetBlock = TSBlock(matchAll(@"Hello").fontSize(40).match(@"type").purple.match(@"set").blue);

    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y / 2, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:textfield];
    textfield.typesetBlock = TSBlock(matchAll(@"1").red);

    textfield.delegate = self;

//    // You can keep adding typeset styles to the same attributed string.
//    NSMutableAttributedString *baselineTest =  @"This is a strikethrough test.".typeset.match(@"This").underline(1).match(@"is a").baseline(5).match(@"strikethrough").strikeThrough(TSSingle).match(@"test").strikeThrough(TSDouble).string;

    label.text = @"Hello typeset, hello.";
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"%@", textField.text);
//    textField.attributedText = textField.typesetBlock(textField.text);
    return YES;
}

@end
