//
//  DBHelper.h
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "FMResultSet.h"

@interface DBHelper : NSObject
+ (DBHelper*)dbHelper;

/// 判断是否存在表
- (BOOL)isTableOK:(NSString *)tableName;

/// 创建表
- (BOOL)createTableSql:(NSString *)sql;

/// 获得数据
- (NSArray *)getDBlist:(NSString *)sql;

/// 获得单条数据
- (NSDictionary *)getDBOneData:(NSString *)sql;

/// 统计数量
- (int)getDBDataCount:(NSString *)sql;

/// 执行sql (主要用来执行插入操作)
- (unsigned)executeInsertSql:(NSString *)sql;

/// 更新操作，删除操作
- (void)executeUpdateSql:(NSString *)sql;

/// 关闭数据库
- (void)closeDatabase;

/**
 *  数据库升级
 */
- (void)migrateDB;
/**
 *  创建用户数据表
 */
- (void)foundUpUserTable;

@end
