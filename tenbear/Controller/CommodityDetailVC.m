//
//  CommodityDetailVC.m
//  tenbear
//
//  Created by 黄达能 on 16/3/25.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "CommodityDetailVC.h"
#import "Constants.h"
#import "CommentCell.h"
@interface CommodityDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSArray <NSString *>*arrayData;
    BOOL isReadingComments;//判断是不是进入了所有评论的界面
    BOOL isCommodityDetail;
    BOOL isPurchaseOrder;
    CGFloat commentViewHeight ;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *commentsView;
@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (weak, nonatomic) IBOutlet UIView *commodityComments;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
#pragma mark - navigation
@property (weak, nonatomic) IBOutlet UIView *navigation;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shoppingCartBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *picDetail;
@property (strong, nonatomic) IBOutlet UIView *commodityDetailView;
@property (strong, nonatomic) IBOutlet UIView *purchaseOrder;
#pragma mark - purchaseOrder

@end

@implementation CommodityDetailVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    _scrollView.bounces = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*3);
    _scrollView.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1.0f];
    _scrollView.delegate = self;
//    _scrollView.contentOffset = CGPointMake(0, 64);
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _commentsTable.delegate = self;
    _commentsTable.dataSource = self;
    arrayData = @[@"这东西很好吃,下次还来.",@"这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.",@"这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来.这东西很好吃,下次还来."];
    int i = arc4random()%3;
    _commentLabel.text = arrayData[i];
    //在scrollView周边增加滚动区域
    //根据评论的长度设置页面的高度
    self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 30+[self commentLabelHeight], 0);
    commentViewHeight = 130-40+[self commentLabelHeight];
    NSLog(@"commentViewHeight-----%f",commentViewHeight);
    NSLog(@"----------%f",commentViewHeight);
    _commodityComments.frame = CGRectMake(_commodityComments.frame.origin.x, _commodityComments.frame.origin.y, SCREEN_WIDTH, commentViewHeight);
}
#pragma mark - 动态计算商品展示界面里评论的高度
-(CGFloat)commentLabelHeight
{
    CGSize size = [_commentLabel sizeThatFits:CGSizeMake(_commentLabel.frame.size.width, MAXFLOAT)];
    return size.height;
}
#pragma mark -TableViewDelegate TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayData.count;
}
//动态计算cell的高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
//    CGSize size = [cell sizeThatFits:CGSizeMake(cell.comment.frame.size.width, MAXFLOAT)];
//    return 1+100-20+size.height;
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
//        CGSize size = [cell sizeThatFits:CGSizeMake(cell.comment.frame.size.width, MAXFLOAT)];
    
    NSString *string = arrayData[indexPath.row];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:13.0f]};
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(_commentLabel.frame.size.width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGFloat commentImageViewHeight ;
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        if (indexPath.row == 0) {
            int imageNum = 3;
            commentImageViewHeight = (((imageNum-1)/3)+1) * 60 + ((imageNum-1)/3 + 1 )*5;
        }
        else{
            int imageNum = 4;
            commentImageViewHeight = (((imageNum-1)/3)+1) * 60 + ((imageNum-1)/3 + 1)*5;
        }
    }
    CGFloat height = 1+100-20+size.height+commentImageViewHeight;
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    if (indexPath.row == 0) {
        cell.isHaveCommentImage = YES;
        cell.commentImageNum = 3;
    }
    if (indexPath.row == 1) {
        cell.isHaveCommentImage = YES;
        cell.commentImageNum = 4;
    }
    cell.comment.text = arrayData[indexPath.row];
    cell.comment.font = [UIFont fontWithName:@"Arial" size:13.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 导航栏按钮
- (IBAction)back:(id)sender {
    if (isPurchaseOrder) {
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = @"oglFlip";//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
        //其它动作{@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
        transition.subtype = kCATransitionFromLeft;//{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
        [_purchaseOrder.layer.superlayer addAnimation:transition forKey:nil];
        [_purchaseOrder.layer addAnimation:transition forKey:nil];
        //[self performSelector:@selector(removeFromView)];
        //[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        [_purchaseOrder removeFromSuperview];
        isPurchaseOrder = NO;
        return;
    }
    if(isReadingComments){
        [UIView beginAnimations:@"back" context:nil];
        [UIView setAnimationDuration:0.7f];
        _commentsView.center = CGPointMake(SCREEN_WIDTH*1.5, SCREEN_HEIGHT/2);
        [UIView commitAnimations];
        [self changeNavgationControllerBack];
        isReadingComments = NO;
        return;
    }
    if(isCommodityDetail){
        [UIView beginAnimations:@"back" context:nil];
        _commodityDetailView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*1.5);
        [UIView commitAnimations];
        _scrollView.hidden = NO;
        [self changeNavgationControllerBack];
        isCommodityDetail = NO;
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)shoppingCart:(id)sender {
}
- (IBAction)more:(id)sender {
}
#pragma mark - 显示所有评论
- (IBAction)comments:(id)sender {
    _commentsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _commentsView.center = CGPointMake(SCREEN_WIDTH*1.5, SCREEN_HEIGHT/2);
    [self.view insertSubview:_commentsView aboveSubview:_scrollView];
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5f];
    _commentsView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [UIView commitAnimations];
    [self changeNavgationController];
    isReadingComments = YES;
}
-(void)changeNavgationController
{
    _titleLabel.hidden = NO;
    _navigation.backgroundColor = [UIColor whiteColor];
    [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_shoppingCartBtn setImage:[UIImage imageNamed:@"_gwc"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
}
-(void)changeNavgationControllerBack
{
    _titleLabel.hidden = YES;
    _navigation.backgroundColor = [UIColor clearColor];
    [_backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [_shoppingCartBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"m"] forState:UIControlStateNormal];
}
#pragma mark -UIScrollerViewDelegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isReadingComments) {
        return;
    }
    if (isCommodityDetail) {
        return;
    }
    if (scrollView.contentOffset.y > commentViewHeight) {
        _commodityDetailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _commodityDetailView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*1.5);
        _scrollView.hidden = YES;
        
        UIImageView * imgView = [[UIImageView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"detail" ofType:@"png"];
        imgView.image = [UIImage imageWithContentsOfFile:path];
        imgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imgView.image.size.height);
        imgView.userInteractionEnabled = YES;
        _picDetail.contentSize = CGSizeMake(SCREEN_WIDTH, imgView.image.size.height);
        [_picDetail addSubview:imgView];
        [self.view insertSubview:_commodityDetailView belowSubview:self.navigation];
        [UIView beginAnimations:@"commodityDetail" context:nil];
        [UIView setAnimationDuration:0.7f];
        _commodityDetailView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [UIView commitAnimations];
        [self changeNavgationController];
        _titleLabel.hidden = YES;
        isCommodityDetail = YES;
    }
    NSLog(@"位移-------%f",scrollView.contentOffset.y);
}
#pragma mark - 分享
- (IBAction)share:(id)sender {
    
}
#pragma mark - tabbar
- (IBAction)customerService:(id)sender {
}
- (IBAction)shops:(id)sender {
}
- (IBAction)collection:(id)sender {
}

- (IBAction)addToCart:(id)sender {
}
- (IBAction)purchase:(id)sender {
//    _purchaseOrder.center = CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT*1.5);
    _purchaseOrder.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _purchaseOrder.backgroundColor = [UIColor clearColor];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.7f];
    [applicationLoadViewIn setType:kCATransitionMoveIn];
    //{@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[_purchaseOrder layer]addAnimation:applicationLoadViewIn forKey:nil];
    [self.view addSubview:_purchaseOrder];

    isPurchaseOrder = YES;
}
@end
