//
//  DBHelper.m
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import "DBHelper.h"
#import "Constants.h"
#import <sqlite3.h>

@implementation DBHelper{
    FMDatabase *dataBase;
    FMDatabaseQueue *queue;
}

- (id)init {
    self = [super init];
    if(self){
        NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbFilePath = [doc stringByAppendingPathComponent:@"xiangquSailor.sqlite"];
        NSLog(@"沙盒路径：%@",dbFilePath);
        queue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
        dataBase = [FMDatabase databaseWithPath:dbFilePath];
    }
    return self;
}

+ (DBHelper*)dbHelper {
    static DBHelper *dbHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbHelper = [[DBHelper alloc] init];
    });
    return dbHelper;
}


/**
 *  数据库升级,使用前需判断是否已升级
 */
- (void)migrateDB {
    //    NSLog(@"build:%d",appBuild);
    if (appBuild == 3) {
        //        [self executeUpdateSql:@"ALTER table user add column userid VARCHAR(20)"];
        [self executeUpdateSql:@"ALTER table user add column realname VARCHAR(100)"];
    }
}

/**
 *  创建用户数据表
 */
- (void)foundUpUserTable {
    [self createTableSql:@"create table user (id INTEGER PRIMARY KEY,userid VARCHAR(20),username VARCHAR(20),nickname VARCHAR(100),realname VARCHAR(50),email VARCHAR(50),school VARCHAR(50),birthday VARCHAR(50),gender VARCHAR(10),token VARCHAR(50),avatar VARCHAR(100))"];
}

/// 判断是否存在表
- (BOOL)isTableOK:(NSString *)tableName
{
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = '%@'", tableName];
    int count = [self getDBDataCount:sql];
    NSLog(@"Table count===%d", count);
    if (count > 0) {
        return YES;
    }
    return NO;
}

/// 创建表
- (BOOL)createTableSql:(NSString *)sql
{
    __block unsigned mid = 0;
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSLog(@"%@", sql);
        BOOL success = [db executeStatements:sql];
        NSLog(@"sql语句执行成功 %d", success);
        mid = success;
    }];
    return mid;
}

/// 获得数据
- (NSArray *)getDBlist:(NSString *)sql
{
    __block NSMutableArray *list = [[NSMutableArray alloc] init];
    NSLog(@"%@", sql);
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
            [list addObject:dictionary];
            return 0;
        }];
    }];
    return list;
}

/// 获得单条数据
- (NSDictionary *)getDBOneData:(NSString *)sql
{
    __block NSMutableArray *list = [[NSMutableArray alloc] init];
    NSLog(@"%@", sql);
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
            [list addObject:dictionary];
            return 0;
        }];
    }];
    
    if (list.count == 1) {
        return [list objectAtIndex:0];
    }
    
    return nil;
}


/// 统计数量
- (int)getDBDataCount:(NSString *)sql
{
    int count = 0;
    __block NSMutableArray *list = [[NSMutableArray alloc] init];
    NSLog(@"%@", sql);
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
            
            [list addObject:dictionary];
            
            return 0;
        }];
        
    }];
    
    if (list.count == 1) {
        NSDictionary *dict = [list objectAtIndex:0];
        if (dict) {
            count = [[dict objectForKey:@"count"] intValue];
        }
    }
    NSLog(@"getDBDataCount count===%d", count);
    
    return count;
}

- (unsigned)executeInsertSql:(NSString *)sql
{
    __block unsigned mid = 0;
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSLog(@"%@", sql);
        BOOL success = [db executeStatements:sql];
        NSLog(@"sql语句执行成功 %d", success);
        sqlite_int64 lastId = [db lastInsertRowId];
        mid = (unsigned)lastId;
    }];
    
    return mid;
}

/// 更新操作，删除操作
- (void)executeUpdateSql:(NSString *)sql
{
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        //        NSLog(@"%@", sql);
        BOOL success = [db executeStatements:sql];
        NSLog(@"sql语句执行成功 %d", success);
    }];
}

/// 关闭数据库
- (void)closeDatabase
{
    [dataBase close];
}


@end
