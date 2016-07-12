//
//  MyWalletVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/8.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "MyWalletVC.h"
#import "StockIndexVC.h"

#import "GetCashVC.h"
#import "BillVC.h"
@interface MyWalletVC ()
- (IBAction)BackClick:(id)sender;
- (IBAction)stockIndexClick:(UIButton *)sender;
- (IBAction)withDrawal:(id)sender;

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (IBAction)BackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击股指
- (IBAction)stockIndexClick:(UIButton *)sender {
    StockIndexVC *stockIndexVC = [[StockIndexVC alloc] init];
    [self.navigationController pushViewController:stockIndexVC animated:YES];
}


- (IBAction)withDrawal:(id)sender {
    GetCashVC *cash = [[GetCashVC alloc]init];
    [self.navigationController pushViewController:cash animated:YES];
    
}
- (IBAction)BillClick:(id)sender {
    BillVC *bill = [[BillVC alloc]init];
    [self.navigationController pushViewController:bill animated:YES];
}

@end
