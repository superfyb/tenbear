//
//  DynamicDetailsVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "DynamicDetailsVC.h"
#import "ShareCell.h"
#import "Constants.h"
#define identifier @"DynamicDetailsCell"
#define cellViewHeight SCREEN_WIDTH*5/6
@interface DynamicDetailsVC ()
@property (nonatomic, strong) UIView *footView;
@end

@implementation DynamicDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headView = [[UIView alloc] init];
    ShareCell *cellView = [[NSBundle mainBundle] loadNibNamed:@"ShareCell" owner:self options:nil].lastObject;
    cellView.praiseButton.hidden = YES;
    cellView.shareButton.hidden = YES;
    cellView.discussButton.hidden = YES;
    cellView.frame = CGRectMake(0, 0, SCREEN_WIDTH, cellViewHeight);
    [headView addSubview:cellView];
    
    UILabel *praise = [[UILabel alloc] init];
    praise.text = @"赞:";
    praise.textColor = [UIColor grayColor];
    praise.frame = CGRectMake(20, cellViewHeight-20, 30, 30);
    [headView addSubview:praise];
    
    for(int i=0;i<=1;i++){
        UIImageView *praiseView = [[UIImageView alloc] init];
        praiseView.frame = CGRectMake(60+i*40, cellViewHeight-20, 30, 30);
        praiseView.image = [UIImage imageNamed:@"ba7603e1jw8f16ravbo1uj20e80e8jrq.jpg"];
        praiseView.layer.cornerRadius = 15;
        praiseView.layer.masksToBounds = YES;
        [headView addSubview:praiseView];
    }
    
    UIButton *praiseButton = [[UIButton alloc] init];
    praiseButton.frame = CGRectMake(SCREEN_WIDTH-80, cellViewHeight-20, 60, 30);
    [praiseButton setImage:[UIImage imageNamed:@"dz"] forState:UIControlStateNormal];
    [praiseButton setTitle:@"687" forState:UIControlStateNormal];
    [praiseButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    praiseButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:praiseButton];
    
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, cellViewHeight+30);
    self.tableView.tableHeaderView = headView;
    
    //底部评论转发
    self.footView = [[UIView alloc] init];
    self.footView.backgroundColor = [UIColor whiteColor];
    self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    //评论按钮
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2-0.5, 50);
    [leftButton setTitle:@"  评论" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftButton setImage:[UIImage imageNamed:@"b-pl"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.footView addSubview:leftButton];
    
    //转发按钮
    UIButton *rightButton = [[UIButton alloc] init];
    rightButton.frame = CGRectMake(SCREEN_WIDTH/2+0.5, 0, SCREEN_WIDTH/2-0.5, 50);
    [rightButton setTitle:@"  转发" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.footView addSubview:rightButton];
    
    //竖线
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(SCREEN_WIDTH/2+0.5, 10, 1, 30);
    line.backgroundColor = [UIColor grayColor];
    [self.footView addSubview:line];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar addSubview:self.footView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.footView removeFromSuperview];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"精彩评论";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DynamicDetailsCell" owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH*7/32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

@end
