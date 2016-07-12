//
//  ShoppingCarVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/4.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ShoppingCarVC.h"
#import "Constants.h"
#import "WaitForPaymentVC.h"
#import "ConfirmOrderVC.h"
#import "OrderDetailsVC.h"
#import "ShoppingCarCell.h"
#import "ShoppingCarEditCell.h"

#define identifier @"ShoppingCarCell"
#define editIdentifier @"ShoppingCarEditCell"
@interface ShoppingCarVC ()<UITableViewDataSource,UITableViewDelegate>
- (IBAction)allClick:(UIButton *)sender;
- (IBAction)editButtonClick:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UIButton *settlementButton;
@property (strong, nonatomic) IBOutlet UILabel *textLabel1;
@property (strong, nonatomic) IBOutlet UILabel *textLabel2;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *allSelectButton;

@property (assign, nonatomic) BOOL isEdit;
@end

@implementation ShoppingCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isEdit = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (self.isEdit) {
        cell = [tableView dequeueReusableCellWithIdentifier:editIdentifier];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    if (!cell) {
        if (self.isEdit) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ShoppingCarEditCell" owner:self options:nil].lastObject;
        }
        else{
            cell = [[NSBundle mainBundle] loadNibNamed:@"ShoppingCarCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (self.allSelectButton.selected) {
        if (self.isEdit) {
            ShoppingCarEditCell *commonCell = (ShoppingCarEditCell *)cell;
            commonCell.selectButton.selected = YES;
        }
        else{
            ShoppingCarCell *editCell = (ShoppingCarCell *)cell;
            editCell.selectButton.selected = YES;
        }
    }else{
        if (self.isEdit) {
            ShoppingCarEditCell *commonCell = (ShoppingCarEditCell *)cell;
            commonCell.selectButton.selected = NO;
        }
        else{
            ShoppingCarCell *editCell = (ShoppingCarCell *)cell;
            editCell.selectButton.selected = NO;
        }
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section%2) {
        OrderDetailsVC *orderDetailsVC = [[OrderDetailsVC alloc] init];
        [self.navigationController pushViewController:orderDetailsVC animated:YES];
    }
    else{
        ConfirmOrderVC *waitForPaymentVC = [[ConfirmOrderVC alloc] init];
        [self.navigationController pushViewController:waitForPaymentVC animated:YES];
    }
}

//编辑状态
- (IBAction)editButtonClick:(UIBarButtonItem *)sender {
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        self.textLabel1.hidden = YES;
        self.textLabel2.hidden = YES;
        self.moneyLabel.hidden = YES;
        [self.settlementButton setTitle:@"删除" forState:UIControlStateNormal];
        [sender setTitle:@"完成"];
        [sender setImage:nil];
    }
    else{
        self.textLabel1.hidden = NO;
        self.textLabel2.hidden = NO;
        self.moneyLabel.hidden = NO;
        [self.settlementButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"icon-bj"]];
        [sender setTitle:nil];
    }
    [self.tableView reloadData];
}

//全选
- (IBAction)allClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.tableView reloadData];

}
@end
