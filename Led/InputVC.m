//
//  InputVC.m
//  Led
//
//  Created by tam on 1/17/14.
//  Copyright (c) 2014 tam. All rights reserved.
//

#import "InputVC.h"
#import "Font.h"

@interface InputVC () <UITextFieldDelegate>

@end

@implementation InputVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tf.delegate = self;
    _tf.text = @"Input";
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
