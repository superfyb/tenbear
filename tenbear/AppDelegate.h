//
//  AppDelegate.h
//  tenbear
//
//  Created by fengyibo on 16/3/4.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+(AppDelegate *)sharedAppDelegate;

@property(strong,nonatomic)NSString *userToken;

@property (strong, nonatomic) UIWindow *window;

@end

