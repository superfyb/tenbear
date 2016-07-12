//
//  OrderBaseVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/25.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "OrderBaseVC.h"

@interface OrderBaseVC ()

@end

@implementation OrderBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
