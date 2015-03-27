//
//  MessageEditViewController.m
//  testprofile
//
//  Created by 村上優孝 on 2015/03/27.
//  Copyright (c) 2015年 村上優孝. All rights reserved.
//

#import "MessageEditViewController.h"
#import "ImageUtility.h"

@interface MessageEditViewController ()

@property UITextField *textfield;

@end

@implementation MessageEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake( 20, 100, self.view.frame.size.width - 40, 30)];
    self.textfield.borderStyle = UITextBorderStyleRoundedRect;
    self.textfield.delegate = self;
    [self.view addSubview:self.textfield];
    
    UIButton *myButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setFrame:CGRectMake(20, 140, self.view.frame.size.width - 40 , 50)];
    [myButton setBackgroundColor:[UIColor greenColor]];
    [myButton setTitle:@"保存" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    [myButton setBackgroundImage:[ImageUtility imageWithColor:[UIColor greenColor]] forState:UIControlStateHighlighted];
    
    [self.view addSubview:myButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonPressed:(UIButton *)button{
    [[NSUserDefaults standardUserDefaults] setObject:self.textfield.text forKey:@"message"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
