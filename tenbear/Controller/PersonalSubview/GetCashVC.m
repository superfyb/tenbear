//
//  GetCashVC.m
//  tenbear
//
//  Created by 黄达能 on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "GetCashVC.h"
#define Background [UIColor colorWithRed:247/255.0 green:248/255.0 blue:249/255.0 alpha:1]
@interface GetCashVC ()

- (IBAction)back:(id)sender;

- (IBAction)cardMes:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *moneyNum;

@end

@implementation GetCashVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Background;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cardMes:(id)sender {
}
- (IBAction)okBtnClick:(id)sender {
}
@end
