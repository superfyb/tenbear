//
//  BillVC.m
//  tenbear
//
//  Created by 黄达能 on 16/3/24.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "BillVC.h"
#import "BillTableViewCell.h"
#import "StockDetailVC.h"
#import "Constants.h"
@interface BillVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *billTable;
    
    NSArray *sectionArray;
    UIView *grayLayer;
    UIView *sectionLayer;
    BOOL isSelecting;
    NSInteger selectedTag;
}
@end

@implementation BillVC
-(NSArray *)sectionArray
{
    if (!sectionArray) {
        selectedTag = 1;
        sectionArray = @[@"全部",@"分俑",@"分红",@"奖励",@"消费",@"提现",@"其他"];
    }
    return sectionArray;
}
-(void)grayerLayerDismiss
{
    [UIView beginAnimations:@"Dismiss" context:nil];
    [UIView setAnimationDuration:0.6f];
    sectionLayer.center = CGPointMake(SCREEN_WIDTH/2, -sectionLayer.frame.size.height/2);
    [UIView commitAnimations];
    [grayLayer removeFromSuperview];
    sectionLayer = nil;
    isSelecting = NO;
}
-(UIView *)grayLayer
{
    if (!grayLayer) {
        grayLayer = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        grayLayer.backgroundColor = [UIColor blackColor];
        grayLayer.alpha = 0.5;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(grayerLayerDismiss)];
        [grayLayer addGestureRecognizer:tap];
    }
    return grayLayer;
}
-(UIView *)sectionLayer
{
    if (!sectionLayer) {
        sectionLayer = [[UIView alloc]initWithFrame:CGRectMake(0, -120, SCREEN_WIDTH, 120)];
        sectionLayer.backgroundColor = [UIColor whiteColor];
        CGFloat spaceX = 15;
        CGFloat spaceY = 10;
        CGFloat width = (SCREEN_WIDTH -6*spaceX)/3;
        CGFloat height = 25;
        
        for (int i = 0; i < self.sectionArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(spaceX*((i%3)*2+1)+ width*(i%3), (i/3+1)*spaceY+height*(i/3), width, height);
            if (i != selectedTag -1 ) {
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.layer.borderWidth = 0.6;
                btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }
            else{
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor redColor];
            }
            [btn setTitle:self.sectionArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.layer.cornerRadius = height/2;
            btn.layer.masksToBounds = YES;
            btn.tag = i + 1;
            [btn addTarget:self action:@selector(reloadBillData:) forControlEvents:UIControlEventTouchUpInside];
            [sectionLayer addSubview:btn];
        }
    }
    return sectionLayer;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    billTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    billTable.delegate = self;
    billTable.dataSource = self;
    [self.view addSubview:billTable];
    [self sectionLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - reloadBillData
-(void)reloadBillData:(UIButton *)sender
{
    if (sender.tag == selectedTag) {
        [self grayerLayerDismiss];
        return;
    }
    UIButton *selectedBtn = (UIButton *)[self.sectionLayer viewWithTag:selectedTag];
    selectedBtn.backgroundColor = [UIColor whiteColor];
    [selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectedBtn.layer.borderWidth = 0.6;
    selectedBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    sender.backgroundColor = [UIColor redColor];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.layer.borderWidth = 0;
    
    selectedTag = sender.tag;
    [self grayerLayerDismiss];
}
#pragma mark -导航栏按钮
- (IBAction)selection:(id)sender {
    if (isSelecting) {
        [self grayerLayerDismiss];
        return;
    }
    [self.view addSubview:self.grayLayer];
    [self.view addSubview:self.sectionLayer];
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.6f];
    self.sectionLayer.center = CGPointMake(SCREEN_WIDTH/2, sectionLayer.frame.size.height/2+64);
    [UIView commitAnimations];
    isSelecting = YES;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -TableViewDelegate TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"2016年%ld月",section+1];
    return title;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 15;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"BillTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StockDetailVC *stockDetail = [[StockDetailVC alloc]init];
    [self.navigationController pushViewController:stockDetail animated:YES];
}
@end
