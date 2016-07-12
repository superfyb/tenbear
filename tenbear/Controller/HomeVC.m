//
//  HomeVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/4.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "HomeVC.h"
#import "Constants.h"
#import "HomeViewCell.h"
#import "CommodityDetailVC.h"
@interface HomeVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
//搜索框
@property (strong, nonatomic) UIView *searchView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:colorNavi];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, 0,40, 40);//button的frame
    //在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
    [leftButton setImage:[UIImage imageNamed:@"category"] forState:UIControlStateNormal];//给button添加image
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0,10,10,5);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    [leftButton setTitle:@"分类" forState:UIControlStateNormal];//设置button的title
    leftButton.titleLabel.font = [UIFont systemFontOfSize:10];//title字体大小
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    leftButton.titleEdgeInsets = UIEdgeInsetsMake(25, -20, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(SCREEN_WIDTH-50, 0,40, 40);//button的frame
    //在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
    [rightButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];//给button添加image
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0,10,10,5);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    [rightButton setTitle:@"消息" forState:UIControlStateNormal];//设置button的title
    rightButton.titleLabel.font = [UIFont systemFontOfSize:10];//title字体大小
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(25, -20, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    
    [rightButton addTarget:self action:@selector(commodityDetail) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/2, NavigationBar_HEIGHT-20)];
    self.searchView.backgroundColor = colorNavi;
    //searchBar 设置
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.searchView.frame.size.width, self.searchView.frame.size.height)];
    self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.delegate = self;
    self.searchBar.barTintColor = colorNavi;
    self.searchBar.translucent = NO;
    self.searchBar.layer.borderColor = colorNavi.CGColor;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.placeholder = NavigationpLaceholder;
    [self.searchView addSubview:self.searchBar];
    self.navigationItem.titleView = self.searchView;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT);
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden = @"homeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    NSArray *imageArr = [NSArray arrayWithObjects:@"十分享_14",@"",@"十分享_28",@"十分享_30",@"十分享_19", nil];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.section];
    if (indexPath.section == 1) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeViewCell" owner:self options:nil] lastObject];
        
    }
    else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3);
        imageView.image = [UIImage imageNamed:imageArr[indexPath.section%5]];
        imageView.backgroundColor = [UIColor redColor];
        [cell addSubview:imageView];
    }
    return cell;
}

#pragma mark - tableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return SCREEN_WIDTH/2;
    }
    else{
        return SCREEN_WIDTH/3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}
#pragma mark - 商品详情
-(void)commodityDetail
{
    CommodityDetailVC * commodity = [[CommodityDetailVC alloc]initWithNibName:@"CommodityDetailVC" bundle:nil];
    [self.navigationController pushViewController:commodity animated:YES];
}

@end
