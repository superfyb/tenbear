//
//  PersonalCenterVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/4.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "Constants.h"
#import "MyWalletVC.h"
#import "MyCardVC.h"
#import "InviteFriendVC.h"
#import "MyPartnerVC.h"
#import "AccountSecurityVC.h"
#import "MessageVC.h"
#import "LoginRegisterVC.h"

#define Identifier @"personalCell"


@interface PersonalCenterVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation PersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;

    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView.backgroundColor = colorBack;
    self.tableView.tintColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    CGFloat headViewHeight = SCREEN_WIDTH*3/7;
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = colorNavi;
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight);
    self.tableView.tableHeaderView = headView;
    
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = colorNavi;
    coverView.frame = CGRectMake(0, -300, SCREEN_WIDTH, 300);
    [self.tableView.tableHeaderView addSubview:coverView];
    
    //头像

    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = CGRectMake(SCREEN_WIDTH/2-SCREEN_WIDTH/10, 10, SCREEN_WIDTH/5, SCREEN_WIDTH/5);
    headButton.layer.cornerRadius = SCREEN_WIDTH/10;
    headButton.layer.masksToBounds = YES;
    [headButton setImage:[UIImage imageNamed:@"ba7603e1jw8f0za6kr1dij20yi0yidhr.jpg"] forState:UIControlStateNormal];
    [headButton addTarget:self action:@selector(loginOrRegister) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:headButton];

    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(SCREEN_WIDTH/4, 15+SCREEN_WIDTH/5, SCREEN_WIDTH/2, 20);
    nameLabel.text = @"superfyb";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:nameLabel];
    
    //我的收藏
    UIButton *collectButton = [[UIButton alloc] init];
    collectButton.frame = CGRectMake(0, headViewHeight-SCREEN_WIDTH/10, SCREEN_WIDTH/2-0.5, SCREEN_WIDTH/10);
    [collectButton setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateNormal];
//    collectButton.imageEdgeInsets = UIEdgeInsetsMake(10, 20,10, SCREEN_WIDTH/2-40);
    [collectButton setTitle:@"  我的收藏   8" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    collectButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    collectButton.titleEdgeInsets = UIEdgeInsetsMake(10, 30, 10, SCREEN_WIDTH/2-160);
    collectButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [headView addSubview:collectButton];
    
    //推荐的好友
    UIButton *recommendButton = [[UIButton alloc] init];
    recommendButton.frame = CGRectMake(SCREEN_WIDTH/2+0.5, headViewHeight-SCREEN_WIDTH/10, SCREEN_WIDTH/2-1, SCREEN_WIDTH/10);
    [recommendButton setImage:[UIImage imageNamed:@"hy"] forState:UIControlStateNormal];
//    recommendButton.imageEdgeInsets = UIEdgeInsetsMake(10, 20,10, SCREEN_WIDTH/2-40);
    [recommendButton setTitle:@"  推荐的好友   20" forState:UIControlStateNormal];
    [recommendButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    recommendButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    recommendButton.titleEdgeInsets = UIEdgeInsetsMake(10, 30, 10, SCREEN_WIDTH/2-160);
    recommendButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [headView addSubview:recommendButton];
    
    //白色竖线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.frame = CGRectMake(SCREEN_WIDTH/2-0.5, headViewHeight-SCREEN_WIDTH/10+4, 1, SCREEN_WIDTH/10-8);
    [headView addSubview:lineView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleTextArr = [NSArray arrayWithObjects:@"我的订单",@"",@"我的钱包",@"银行卡",@"购物车",@"收货地址",@"邀请二维码",@"推荐的好友",@"消息",@"帮助",@"帐户安全",@"退出登录", nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PersonalCenterViewCell" owner:self options:nil].lastObject;
        }
        else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    cell.textLabel.text = titleTextArr[indexPath.row+indexPath.section*2];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"icon1"];
        cell.detailTextLabel.text = @"查看全部购买商品";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    else if(indexPath.section != 0){
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%ld",indexPath.row+indexPath.section*2]];
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 && indexPath.section == 0) {
        return SCREEN_WIDTH/6;
    }
    else{
        return SCREEN_WIDTH/7;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SCREEN_WIDTH/45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    NSString *title = cell.textLabel.text;
    if ([title isEqualToString:@"我的钱包"]) {
        
         MyWalletVC *myWalletVC = [[MyWalletVC alloc] init];
        [self.navigationController pushViewController:myWalletVC animated:YES];
    }
    else if ([title isEqualToString:@"银行卡"]){
        MyCardVC *mycardVC = [[MyCardVC alloc] init];
        [self.navigationController pushViewController:mycardVC animated:YES];
    }
    else if ([title isEqualToString:@"邀请二维码"]){
        InviteFriendVC *inviteVC = [[InviteFriendVC alloc] init];
        [self.navigationController pushViewController:inviteVC animated:YES];
    }
    else if ([title isEqualToString:@"推荐的好友"]){
        MyPartnerVC *partner = [[MyPartnerVC alloc] init];
        [self.navigationController pushViewController:partner animated:YES];
    }
    else if ([title isEqualToString:@"帐户安全"]){
        AccountSecurityVC *accVC = [[AccountSecurityVC alloc] init];
        [self.navigationController pushViewController:accVC animated:YES];
    }
    else if ([title isEqualToString:@"消息"]){
        MessageVC *messVC = [[MessageVC alloc] init];
        [self.navigationController pushViewController:messVC animated:YES];
    }
}
#pragma mark - 登入 注册用户
-(void)loginOrRegister
{
    LoginRegisterVC *login = [[LoginRegisterVC alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}
@end
