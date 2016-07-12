//
//  HudHelper.h
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HudHelper : NSObject
+(HudHelper*)hudHepler;
-(void)ShowHUDAlert:(UIView*)view;
-(void)HideHUDAlert:(UIView*)view;
-(void)showShortTips:(UIView*)view tips:(NSString*)message;
-(void)showTips:(UIView*)view tips:(NSString*)message;
-(void)showLongTips:(UIView*)view tips:(NSString*)message;
-(void)showUIAlert:(NSString*)title;

@end
