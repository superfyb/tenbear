//
//  ResetPwdValidateVC.m
//  tenbear
//
//  Created by 黄达能 on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ResetPwdValidateVC.h"
#import "Constants.h"
#import "TextField.h"
#import "ResetPwdVC.h"
@interface ResetPwdValidateVC ()<UITextFieldDelegate>
{
    TextField *phoneNum;
    TextField *validateNum;
    UIButton *nextStep;
}
@end

@implementation ResetPwdValidateVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"重置密码";
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"";
}
-(void)createView
{
    CGFloat x = 25;
    CGFloat y = 20;
    CGFloat width = SCREEN_WIDTH - 2*x;
    CGFloat height = 40;
    phoneNum = [[TextField alloc]initWithFrame:CGRectMake(x, y, width, height) withPlaceHolder:@"输入手机号" withFont:16];
    phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    phoneNum.delegate =self;
    [self.view addSubview:phoneNum];
    
    validateNum = [[TextField alloc]initWithFrame:CGRectMake(x, phoneNum.frame.origin.y+height+y, width, height) withPlaceHolder:@"输入验证码" withFont:16 withCountDown:60];
    validateNum.delegate = self;
    [self.view addSubview:validateNum];
    
    nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
    nextStep.frame = CGRectMake(x, validateNum.frame.origin.y + validateNum.frame.size.height + y, width, height);
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    nextStep.backgroundColor = BtnGrayColor;
    nextStep.enabled = NO;
    [self.view addSubview:nextStep];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
}
-(void)nextStep
{
    ResetPwdVC *resetPwd = [[ResetPwdVC alloc]init];
    [self.navigationController pushViewController:resetPwd animated:YES];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneNum) {
        return  YES;
    }
    if (textField.text.length >= 6 && ![string isEqualToString:@""]) {
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
