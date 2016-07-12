//
//  AccountSecurityVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/9.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "AccountSecurityVC.h"
#import "Constants.h"
#define identifier @"AccountCell"

@interface AccountSecurityVC ()

@end

@implementation AccountSecurityVC

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"登录密码";
            cell.detailTextLabel.text = @"修改";
            cell.imageView.image = [UIImage imageNamed:@"ok"];
        }break;
        case 1:{
            cell.textLabel.text = @"绑定手机号（尾号1235）";
            cell.detailTextLabel.text = @"换绑";
            cell.imageView.image = [UIImage imageNamed:@"ok"];
        }break;
        case 2:{
            cell.textLabel.text = @"支付密码";
            cell.detailTextLabel.text = @"设置";
            cell.imageView.image = [UIImage imageNamed:@"warning"];
        }break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH/8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
@end
