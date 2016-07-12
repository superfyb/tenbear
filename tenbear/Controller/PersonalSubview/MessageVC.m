//
//  MessageVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/9.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "MessageVC.h"
#import "Constants.h"
#define identifier @"MessageCell"
@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"账户安全";
    self.tableView.backgroundColor = colorBack;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    back.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = item;

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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"系统消息";
            cell.detailTextLabel.text = @"[发红包]5月1日前购买任一商品，免运费江浙沪";
            cell.imageView.image = [UIImage imageNamed:@"system"];
        }break;
        case 1:{
            cell.textLabel.text = @"订单消息";
            cell.detailTextLabel.text = @"[发红包]5月1日前购买任一商品，免运费江浙沪";
            cell.imageView.image = [UIImage imageNamed:@"order"];
        }break;
        case 2:{
            cell.textLabel.text = @"股值消息";
            cell.detailTextLabel.text = @"恭喜您充值了一百元兑换了本平台20股指";
            cell.imageView.image = [UIImage imageNamed:@"stoke"];
        }break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH/7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
@end
