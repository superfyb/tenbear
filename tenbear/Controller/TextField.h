//
//  TextField.h
//  tenbear
//
//  Created by 黄达能 on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Gray [UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1.0]

#define FontColor [UIColor colorWithRed:165/255.0 green:166/255.0 blue:167/255.0 alpha:1]

#define BtnRedColor [UIColor colorWithRed:255/255.0 green:20/255.0 blue:20/255.0 alpha:1.0]

#define BtnGrayColor [UIColor colorWithRed:223/255.0 green:225/255.0 blue:226/255.0 alpha:1]

#define URL @"http://120.26.55.28:5056/"


@interface TextField : UITextField

@property(nonatomic,strong) void(^getTestCode)();

-(TextField *)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeHolder;

-(TextField *)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeHolder withFont:(CGFloat)font;
//倒计时
-(TextField *)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeHolder withFont:(CGFloat)font withCountDown:(int)time;
@end
