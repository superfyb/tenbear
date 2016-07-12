//
//  ShareVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/11.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ShareVC.h"
#import "Constants.h"
#import "ShareCell.h"
#import "OrderView.h"
#import "OrderBaseCell.h"
#import "DynamicDetailsVC.h"

#define identifier @"ShareCell"
@interface ShareVC ()<ShareCellDelegate>
@property (strong, nonatomic) UIView *backView;//背景试图
@property (strong, nonatomic) UIImageView *showView;//背景上的ImageView
@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToTableView)]];
    }
    return _backView;
}

- (void)backToTableView{
    [self.backView removeFromSuperview];
    [self.showView removeFromSuperview];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShareCell" owner:self options:nil].lastObject;
        cell.delegate = self;
        if (indexPath.section%2) {
            cell.videoCutImage.hidden = YES;
            cell.playButton.hidden = YES;
            cell.mainLabel.text = @"【二十个鲜为人知的超实用烹饪技巧】 据说将剪开口的栗子放在微波中加热一下，它的外壳就可以轻松去除；烤红薯的中途捏一捏，红薯会更加香甜，今天，下厨房就搜罗了20个超实用的烹饪技巧，汇成一个集合帖，大家一定要收藏好哦！ ";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH*5/6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicDetailsVC *dynamicVC = [[DynamicDetailsVC alloc] init];
    [[self viewController].navigationController pushViewController:dynamicVC animated:YES];
}

- (UIViewController *)viewController
{
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


#pragma mark - ShareCellDelegate(图片点击放大)
- (void)Play:(UIButton *)button{
    [self.view.window addSubview:self.backView];
    ShareCell *cell = (ShareCell *)button.superview.superview;

    //获取cell在屏幕中的位置
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:[self.tableView indexPathForCell:cell]];
    CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];

    UIImageView *showView = [[UIImageView alloc] init];
    self.showView = showView;
    showView.frame = CGRectMake(button.frame.origin.x, rectInSuperview.origin.y+button.frame.origin.y+60, button.frame.size.width, button.frame.size.height);
    if (button == cell.playButton) {
        showView.image = cell.videoCutImage.image;
    }
    else{
        showView.image = button.imageView.image;
    }
    [self.backView addSubview:showView];

    [UIView animateWithDuration:0.3 animations:^{
        showView.frame = CGRectMake(0, 0, SCREEN_WIDTH, showView.image.size.height/showView.image.size.width*SCREEN_WIDTH);
        showView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }];
}

@end
