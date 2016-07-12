//
//  ConfirmOrderVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/28.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "OrderBaseCell.h"
#import "Constants.h"
#define identifier @"OrderBaseCell"
@interface ConfirmOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)confirmButtonClick:(id)sender;
@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.tableView.tableHeaderView = self.headView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 选择支付方式
- (IBAction)confirmButtonClick:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择支付方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"微信支付" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"银行卡" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:nil];
}

//#pragma mark - 减少宝贝数量
//- (IBAction)reduceButtonClick:(UIButton *)sender {
//    //当宝贝数量为1时，数量不能再减少
//    if ([self.numLabel.text isEqualToString:@"1"]) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"宝贝不能再减少了" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
//        [alertController addAction:cancel];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//    else{
//        self.numLabel.text = [NSString stringWithFormat:@"%d",[self.numLabel.text intValue] - 1];
//    }
//}
//
//#pragma mark - 增加宝贝数量
//- (IBAction)addButtonClick:(UIButton *)sender {
//    self.numLabel.text = [NSString stringWithFormat:@"%d",[self.numLabel.text intValue] + 1];
//}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"OrderBaseCell" owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodsNum = indexPath.section+1;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%lf",SCREEN_WIDTH*5/8+indexPath.section*SCREEN_WIDTH/3);
//    return SCREEN_WIDTH*5/8+SCREEN_WIDTH;
    return SCREEN_WIDTH*5/8+SCREEN_WIDTH*(1+indexPath.section)/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
@end
