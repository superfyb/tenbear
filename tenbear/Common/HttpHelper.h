//
//  HttpHelper.h
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"

@interface HttpHelper : NSObject
@property (strong, nonatomic)AFHTTPRequestOperationManager *manager;
+ (HttpHelper *)httpHelper;
/**
 *  Basic Get
 */
- (void)basicGet:(NSString*)subUrl params:(id)params complete:(void (^)(id data))complete failed:(void (^)(NSError *error))failed;

/**
 *  Basic Post
 */
- (void)basicPost:(NSString*)subUrl params:(id)params complete:(void (^)(id data))complete failed:(void (^)(NSError *error))failed;
@end
