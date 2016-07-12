//
//  HttpHelper.m
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import "HttpHelper.h"

@implementation HttpHelper

@synthesize manager;

+ (HttpHelper *)httpHelper {
    static HttpHelper *httpHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpHelper = [[HttpHelper alloc] init];
        
        httpHelper.manager = [AFHTTPRequestOperationManager manager];
        httpHelper.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        httpHelper.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        [httpHelper.manager.requestSerializer setValue:headValue forHTTPHeaderField:headKey];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[HttpHelper httpHelper].manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [[HttpHelper httpHelper].manager.requestSerializer setValue:@"langjullaannggjjuu!" forHTTPHeaderField:@"JOKE"];
        });
//        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//        [httpHelper.manager.requestSerializer setValue:appDelegate.userToken forHTTPHeaderField:@"Authorization"];
        //        [httpHelper.manager.requestSerializer setValue:contentValue forHTTPHeaderField:contentKey];
        httpHelper.manager.requestSerializer.timeoutInterval = 3;
        //        httpHelper.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",contentValue, nil];
        
        //        NSLog(@"requestSerializer%@",httpHelper.manager.requestSerializer.HTTPRequestHeaders);
    });
    
    return httpHelper;
}

/**
 *  BASIC PART
 *
 */
- (void)basicGet:(NSString*)subUrl params:(id)params complete:(void (^)(id data))complete failed:(void (^)(NSError *error))failed {
    
    [manager GET:[NSString stringWithFormat:@"%@%@%@",API,APIVersion,subUrl] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"operation:%@",operation);
        if (complete) {
            complete([responseObject valueForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)basicHttpGet:(NSString*)url complete:(void (^)(id data))complete failed:(void (^)(NSError *error))failed {
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)basicPost:(NSString*)subUrl params:(id)params complete:(void (^)(id data))complete failed:(void (^)(NSError *error))failed {
    [manager POST:[NSString stringWithFormat:@"%@%@%@",API,APIVersion,subUrl] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"operation:%@",operation);
        //        NSLog(@"responseObject:%@",responseObject);
        if (complete) {
            if([responseObject valueForKey:@"data"] == nil){
                complete([responseObject valueForKey:@"error"]);
            }else{
                complete([responseObject valueForKey:@"data"]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERR:%@",error);
    }];
}

- (void)basicPut:(NSString*)subUrl params:(id)params complete:(void (^)(id data))complete failed:(void (^)(NSError *error))failed {
    [manager PUT:[NSString stringWithFormat:@"%@%@%@",API,APIVersion,subUrl] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"operation:%@",operation.request.HTTPBody);
        //        NSLog(@"responseObject:%@",responseObject);
        if (complete) {
            complete([responseObject valueForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERR:%@",error);
    }];
}

@end
