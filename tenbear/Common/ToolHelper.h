//
//  ToolHelper.h
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ToolHelper : NSObject

+ (ToolHelper*)toolHelper;

- (NSString*)randomString;
- (UIImage*)cropImage:(UIImage*)image;
- (int)charactersInString:(NSString*)string;
/**
 *  分割字符串
 *
 *  @param string 被分割的字符串
 *  @param sep    分隔符
 *
 *  @return 返回可变数组
 */
-(NSMutableArray*)stringToArr:(NSString*)string seprate:(NSString*)sep;
-(UIImage*)scaleToScreenWidth:(UIImage*)origin;
/**
 *  是否首次打开（包括版本升级）
 */
- (BOOL)firstLaunch;
/**
 *  是否已升级数据库
 */
- (BOOL)dbMigrate;
/**
 *  格式化时间戳
 */
- (NSString*)formatDate:(NSUInteger)time style:(NSString*)style;
/**
 *  过滤html
 */
- (NSString *)flattenHTML:(NSString *)html;
/**
 *  友好化距离显示
 */
- (NSString *)formatDistance:(float)distance;
/**
 *  验证邮箱
 */
- (BOOL)validateEmail:(NSString *)email;

/**
 *  验证手机号
 */
- (BOOL)validatePhone:(NSString *)phone;

@end
