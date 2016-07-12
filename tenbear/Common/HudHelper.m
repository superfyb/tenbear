//
//  HudHelper.m
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import "HudHelper.h"

@implementation HudHelper
+(HudHelper*)hudHepler {
    static HudHelper *hudHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hudHelper = [[HudHelper alloc] init];
    });
    return hudHelper;
}
-(void)ShowHUDAlert:(UIView*)view {
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}
-(void)HideHUDAlert:(UIView*)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

-(void)showShortTips:(UIView *)view tips:(NSString*)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}


-(void)showTips:(UIView*)view tips:(NSString*)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}
-(void)showLongTips:(UIView*)view tips:(NSString*)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    
    CGRect txtFrame = label.frame;
    
    label.frame = CGRectMake(10, 100, 300,
                             txtFrame.size.height =[label.text boundingRectWithSize:
                                                    CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height);
    label.frame = CGRectMake(10, 100, 300, txtFrame.size.height);
    hud.customView = label;
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}
-(void)showUIAlert:(NSString*)title {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

@end
