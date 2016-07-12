//
//  CommunityVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/4.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "CommunityVC.h"
#import "Constants.h"
#import "SendDynamicVC.h"
#import "ShareVC.h"
#import "ForumVC.h"

@interface CommunityVC ()
- (IBAction)sendDynamic:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic ,strong) ShareVC *shareVC;
@property (nonatomic ,strong) ForumVC *forumVC;

@end

@implementation CommunityVC
//分享
- (ShareVC *)shareVC{
    if (!_shareVC) {
        _shareVC = [[ShareVC alloc] init];
        _shareVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);

    }
    return _shareVC;
}


//论坛
- (ForumVC *)forumVC{
    if (!_forumVC) {
        _forumVC = [[ForumVC alloc] init];
        _forumVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 110);
    }
    return _forumVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:colorNavi];
    [self.segmentedControl addTarget:self action:@selector(SegmentedControlChange) forControlEvents:UIControlEventValueChanged];
    [self SegmentedControlChange];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}

- (void)SegmentedControlChange{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self.forumVC.view removeFromSuperview];
        [self.view addSubview:self.shareVC.view];
    }
    else{
        [self.shareVC.view removeFromSuperview];
        [self.view addSubview:self.forumVC.view];
    }
}


#pragma mark - 点击发送按钮
- (IBAction)sendDynamic:(id)sender {
    SendDynamicVC *sendDynamicVC = [[SendDynamicVC alloc] init];
    [self.navigationController pushViewController:sendDynamicVC animated:YES];
}
@end
