//
//  OrderDetailsVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/28.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "OrderDetailsVC.h"

@interface OrderDetailsVC ()

@end

@implementation OrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.closeOrderLabel.hidden = NO;
    self.label1.hidden = YES;
    self.timeLabel.hidden = YES;
    [self.payButton setTitle:@"删除订单" forState:UIControlStateNormal];
    self.cancelOrder.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:@"OrderBaseVC" bundle:nil];
    return self;
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
