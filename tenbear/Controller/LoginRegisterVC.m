//
//  LoginRegisterVC.m
//  tenbear
//
//  Created by 黄达能 on 16/3/21.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "LoginRegisterVC.h"
#import "Constants.h"
#import "TextField.h"
#import "ValidateVC.h"
#import "ResetPwdValidateVC.h"
#import "HttpHelper.h"
#define ChangeControllerHeight 50

@interface LoginRegisterVC ()
{
    UIView *loginView;
    UIView *registerView;
    //登入
    TextField *loginPhoneNum;
    TextField *loginPassword;
    //注册
    TextField *registerPhoneNum;
    TextField *registerPassword;
    TextField *registerPasswordAgain;
}
@end

@implementation LoginRegisterVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"十分享";
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航栏标题的字体大小和背景颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Thonburi" size:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = colorNavi;
    
    //设置返回按钮的颜色为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    back.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = item;
    
    
    [self createChangeController];
    [self createLoginView];
    [self createRegisterView];
    [self.view addSubview:loginView];
}
-(void)back
{
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    [self.navigationController popViewControllerAnimated:NO];
    [UIView commitAnimations];
}

-(void)createLoginView
{
    //textfield 控件
    CGFloat x = 25;
    CGFloat y = 20;
    CGFloat width = SCREEN_WIDTH - 2 * x;
    CGFloat height = 40 ;
    loginView = [[UIView alloc]initWithFrame:CGRectMake(0, ChangeControllerHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-ChangeControllerHeight)];
    loginPhoneNum = [[TextField alloc]initWithFrame:CGRectMake(x, y, width, height) withPlaceHolder:@"输入手机号" withFont:16];
    loginPhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    [loginView addSubview:loginPhoneNum];
    
    loginPassword = [[TextField alloc]initWithFrame:CGRectMake(x, loginPhoneNum.frame.origin.y+height+y, width, height) withPlaceHolder:@"输入登入密码" withFont:16];
    [loginView addSubview:loginPassword];
    loginPassword.secureTextEntry = YES;//密码秘密输入
    
    //登入按钮
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(x-5, loginPassword.frame.origin.y + height + 2*y, width+10, height);
    loginBtn.backgroundColor = BtnRedColor;
    [loginBtn setTitle:@"登入" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginBtn];
    
    //忘记密码
    UIButton *forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwd.frame = CGRectMake(self.view.center.x-width/4,loginBtn.frame.origin.y+loginBtn.frame.size.height+6 , width/2, height/1.5);
    [forgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwd setTitleColor:FontColor forState:UIControlStateNormal];
    forgetPwd.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPwd addTarget:self action:@selector(resetPwd) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetPwd];
}
-(void)createRegisterView
{
    //textfield 控件
    CGFloat x = 25;
    CGFloat y = 18;
    CGFloat width = SCREEN_WIDTH - 2 * x;
    CGFloat height = 40 ;
    
    registerView = [[UIView alloc]initWithFrame:CGRectMake(0, ChangeControllerHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-ChangeControllerHeight)];
    registerPhoneNum = [[TextField alloc]initWithFrame:CGRectMake(x, y, width, height) withPlaceHolder:@"" withFont:16];
    registerPhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    [registerView addSubview:registerPhoneNum];
    
    UILabel *remindMes = [[UILabel alloc]initWithFrame:CGRectMake(x+5, y-10, width, height/2)];
    remindMes.text = @"输入手机号";
    remindMes.font = [UIFont systemFontOfSize:12];
    remindMes.textColor = FontColor;
    [registerView addSubview:remindMes];

    registerPassword = [[TextField alloc]initWithFrame:CGRectMake(x, registerPhoneNum.frame.origin.y+height+y, width, height) withPlaceHolder:@"设置登入密码" withFont:16];
    [registerView addSubview:registerPassword];
    registerPassword.secureTextEntry = YES;//密码秘密输入
    
    registerPasswordAgain = [[TextField alloc]initWithFrame:CGRectMake(x, registerPassword.frame.origin.y+height+y, width, height) withPlaceHolder:@"重复登入密码" withFont:16];
    [registerView addSubview:registerPasswordAgain];
    registerPasswordAgain.secureTextEntry = YES;//密码秘密输入
    
    //下一步按钮
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(x-5, registerPasswordAgain.frame.origin.y + height + 2*y, width+10, height);
    nextBtn.backgroundColor = BtnRedColor;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:nextBtn];
}
-(void)createChangeController
{
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, ChangeControllerHeight);
        if (i) {
            [button setTitle:@"注册" forState:UIControlStateNormal];
            [button setBackgroundColor:Gray];
        }
        else{
            [button setTitle:@"登入" forState:UIControlStateNormal];
            button.selected = YES;
        }
        [button addTarget:self action:@selector(buttonChange:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag = i + 1;//登入1 注册2
        //设置button的字体大小
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:button];
    }
}
//由注册改成登入 或则登入改成注册
-(void)buttonChange:(UIButton *)sender
{
    if (sender.selected) {
        //重复点击相同按钮
        return;
    }
    else{
        sender.selected = !sender.selected;
        sender.backgroundColor = [UIColor whiteColor];
        UIButton *anotherButton ;
        if (sender.tag == 1) {
            anotherButton = (UIButton *)[self.view viewWithTag:2];
            [registerView removeFromSuperview];
            [self.view addSubview:loginView];
        }
        else{
            anotherButton = (UIButton *)[self.view viewWithTag:1];
            [loginView removeFromSuperview];
            [self.view addSubview:registerView];
        }
        [anotherButton setBackgroundColor:Gray];
        anotherButton.selected = NO;
    }
}
#pragma mark -登入  下一步  忘记密码
-(void)login
{
    if ([loginPassword.text isEqualToString:@""]||[loginPhoneNum.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"手机号跟密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    NSDictionary *params = @{@"username":loginPhoneNum.text,@"password":loginPassword.text};
    [[HttpHelper httpHelper] basicPost:@"/users/login" params:params complete:^(id data) {
        NSLog(@"%@",data);
        if ([data valueForKey:@"message"]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:[data valueForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failed:nil];
}
-(void)nextStep
{
    if (registerPhoneNum.text.length != 11) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"手机号码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if (registerPassword.text&&registerPassword.text != registerPasswordAgain.text) {
        if (registerPassword.text) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"两次密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        
        return;
    }
    ValidateVC *validate = [[ValidateVC alloc]init];
    validate.phoneNum = registerPhoneNum.text;
    validate.password = registerPassword.text;
    [self.navigationController pushViewController:validate animated:YES];
}
-(void)resetPwd
{
    ResetPwdValidateVC *reset = [[ResetPwdValidateVC alloc]init];
    [self.navigationController pushViewController:reset animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
