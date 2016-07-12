//
//  TabBarController.m
//  tenbear
//
//  Created by fengyibo on 16/3/4.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "TabBarController.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface TabBarController ()<UITabBarControllerDelegate>
@property (assign, nonatomic) AppDelegate *appDelegate;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabBarItems];
}

- (void)setTabBarItems{
    NSArray *itemTitleArr = [NSArray arrayWithObjects:HomeItemName,CommunityItemName,ShoppingCarItemName,PersonalCenterItemName,nil];
    for (NSInteger i = 0; i < 4; i ++) {
        UIViewController *vc = self.viewControllers[i];
        //未选中图片设置
        UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%ld",(long)i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //选中
        UIImage *selectImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBarSelect%ld",(long)i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //初始化Item
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:itemTitleArr[i] image:image selectedImage:selectImage];
//        item.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0);
        item.tag = i;
        vc.tabBarItem = item;
    }
}

#pragma mark - 确定所点击的按钮(并跳到相应页面)
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    self.selectedIndex = item.tag -1;
}

@end
