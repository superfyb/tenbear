//
//  ResetPwdVC.m
//  tenbear
//
//  Created by 黄达能 on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ResetPwdVC.h"
#import "TextField.h"
#import "Constants.h"
@interface ResetPwdVC ()
{
    TextField *password;
    TextField *passwordAgain;
    UIButton *nextStep;
}
@end

@implementation ResetPwdVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"重置密码";
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
}
-(void)createView
{
    CGFloat x = 25;
    CGFloat y = 20;
    CGFloat width = SCREEN_WIDTH - 2*x;
    CGFloat height = 45;
    password = [[TextField alloc]initWithFrame:CGRectMake(x, y, width, height) withPlaceHolder:@"设置新密码" withFont:14];
    password.secureTextEntry = YES;
    [self.view addSubview:password];
    
    passwordAgain = [[TextField alloc]initWithFrame:CGRectMake(x, password.frame.origin.y+password.frame.size.height+y, width, height) withPlaceHolder:@"重复输入密码" withFont:14];
    passwordAgain.secureTextEntry = YES;
    [self.view addSubview:passwordAgain];
    
    nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
    nextStep.frame = CGRectMake(x, passwordAgain.frame.origin.y + passwordAgain.frame.size.height + y, width, height);
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    nextStep.backgroundColor = BtnGrayColor;
    nextStep.enabled = NO;
    [self.view addSubview:nextStep];
}
-(void)nextStep
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
