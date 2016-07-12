//
//  ValidateVC.m
//  tenbear
//
//  Created by 黄达能 on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ValidateVC.h"
#import "Constants.h"
#import "TextField.h"
#import "HttpHelper.h"

@interface ValidateVC ()<UITextFieldDelegate>
{
    TextField *validateTextField;
    UIButton *nextStep;
}
@end

@implementation ValidateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"获取验证码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
}
-(void)createView
{
    CGFloat x = 25;
    CGFloat y = 20;
    CGFloat width = SCREEN_WIDTH - 2*x;
    CGFloat height = 40 ;
    validateTextField = [[TextField alloc]initWithFrame:CGRectMake(x, y, width, height) withPlaceHolder:@"输入验证码" withFont:16 withCountDown:60];
    NSDictionary *params = @{@"mobile":self.phoneNum};
//    [[HttpHelper httpHelper].manager.requestSerializer setValue:[AppDelegate sharedAppDelegate].userToken forHTTPHeaderField:@"Authorization"];
    
    validateTextField.getTestCode = ^{
        [[HttpHelper httpHelper] basicPost:@"/users/code" params:params complete:^(id data) {
            NSLog(@"%@",data);
        } failed:nil];
    };
    validateTextField.delegate = self;
    validateTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:validateTextField];
    
    nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
    nextStep.backgroundColor = BtnGrayColor;
    nextStep.enabled = NO;
    nextStep.frame = CGRectMake(x, validateTextField.frame.origin.y + height + y , width, height);
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 4 && ![string isEqualToString:@""]) {
        return NO;
    }
    if ([string isEqualToString:@""]&&textField.text.length==1) {
        nextStep.backgroundColor = BtnGrayColor;
        nextStep.enabled = NO;
    }
    else{
        nextStep.backgroundColor = BtnRedColor;
        nextStep.enabled = YES;
    }
    return YES;
}
#pragma mark - nextStep
-(void)nextStep
{
    //验证输入的验证码是否正确
    NSDictionary *params = @{@"type":@"1",@"external_uid":self.phoneNum,@"external_name":self.phoneNum,@"token":validateTextField.text,@"password":self.password};
    [[HttpHelper httpHelper] basicPost:@"/users/oauth" params:params complete:^(id data) {
        NSLog(@"%@",data);
        if ([data valueForKey:@"message"]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:[data valueForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failed:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
