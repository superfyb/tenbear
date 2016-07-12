//
//  Constants.h
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define wtdAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

#ifdef DEBUG
#define FLOG(fmt,...)    NSLog((@"[%@][%d] " fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,##__VA_ARGS__)
#else
#define FLOG(str, args...) ((void)0)
#endif

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NavBarFrame self.navigationController.navigationBar.frame

//Bar尺寸
//NavBar高度
#define NavigationBar_HEIGHT 64
//TabBar高度
#define TabBar_HEIGHT 44
//segmentControl高度
#define Segment_HEIGHT 30
//个人中心高度
#define Head_HEIGHT 160

//获取版本
#define appBuild [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] integerValue]

//颜色
//navicolor
#define colorNavi [UIColor colorWithRed:246.0/255.0 green:78.0/255.0 blue:56.0/255.0 alpha:1.0]
#define colorBack [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.0]
#define colorWalletOrange [UIColor colorWithRed:230.0/255.0 green:70.0/255.0 blue:67.0/255.0 alpha:1.0]
//#define colorTheme [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0]
#define colorLetterGray [UIColor colorWithRed:59.0/255.0 green:60.0/255.0 blue:61.0/255.0 alpha:1.0]
#define colorIconGray [UIColor colorWithRed:140.0/255.0 green:142.0/255.0 blue:143.0/255.0 alpha:1.0]
//商店
#define colorStorePurple [UIColor colorWithRed:22.0/255.0 green:10.0/255.0 blue:54.0/255.0 alpha:1.0]

//达人
#define colorNotableGray [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0]

//ItemName
extern NSString * const HomeItemName;
extern NSString * const CommunityItemName;
extern NSString * const ShoppingCarItemName;
extern NSString * const PersonalCenterItemName;

//搜索提示
extern NSString * const NavigationpLaceholder;


//加载与刷新
extern NSString * const headerPullToRefreshText;
extern NSString * const headerReleaseToRefreshText;
extern NSString * const headerRefreshingText;

extern NSString * const footerPullToRefreshText;
extern NSString * const footerReleaseToRefreshText;
extern NSString * const footerRefreshingText;

//APPLICATION
extern NSString * const API;
extern NSString * const APPDomain;
extern NSString * const IMGAPI;
extern NSString * const APIVersion;
extern NSString * const headKey;
extern NSString * const headValue;
extern NSString * const contentKey;
extern NSString * const contentValue;
extern NSString * const headTokenKey;
extern NSString * const appName;
extern NSString * const appScheme;
extern NSString * const userAgreement;

//Weibo
extern NSString * const kAppKey;
extern NSString * const kRedirectURI;
extern NSString * const kwbScheme;
//Weixin
extern NSString * const kwxAppId;
extern NSString * const kwxAppSecret;
extern NSString * const kwxScheme;
//QQ
extern NSString * const kqqAppId;
extern NSString * const kqqAppKey;
extern NSString * const kqqScheme;

@interface Constants : NSObject

@end
