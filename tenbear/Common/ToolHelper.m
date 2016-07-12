//
//  ToolHelper.m
//  zhenpin
//
//  Created by Raychar on 15/12/23.
//  Copyright © 2015年 com.zhenpin. All rights reserved.
//

#import "ToolHelper.h"

NSDate *date;
NSDateFormatter *dateFormatter;

@implementation ToolHelper
+ (ToolHelper*)toolHelper {
    static ToolHelper *toolHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toolHelper = [[ToolHelper alloc] init];
        dateFormatter=[[NSDateFormatter alloc]init];
    });
    return toolHelper;
}

- (NSString*)randomString {
    char data[15];
    for (int x=0;x<10;data[x++] = (char)('a' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:10 encoding:NSUTF8StringEncoding];
}

- (UIImage*)cropImage:(UIImage*)image {
    // Create rectangle from middle of current image
    CGRect croprect = CGRectMake(image.size.width -200, 0 ,
                                 (200), (image.size.height));
    // Draw new image in current graphics context
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], croprect);
    // Create new cropped UIImage
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    return croppedImage;
}

- (int)charactersInString:(NSString*)string {
    int strlength = 0;
    char* p = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

-(NSMutableArray*)stringToArr:(NSString*)string seprate:(NSString*)sep{
    return [NSMutableArray arrayWithArray:[string componentsSeparatedByString:sep]];
}

-(UIImage*)scaleToScreenWidth:(UIImage *)origin {
    CGSize originSize = origin.size;
    CGSize newSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*originSize.height/originSize.width);
    
    UIGraphicsBeginImageContext(originSize);
    [origin drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (BOOL)basicUserDefaults:(NSString*)key {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:key]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        return YES;
    }else{
        return NO;
    }
}

- (void)oppsiteUserDefaults:(NSString*)key {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:key];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    }
}

-(BOOL)firstLaunch{
    return [self basicUserDefaults:[NSString stringWithFormat:@"firstLaunch%@",APIVersion]];
}
/**
 *  是否已升级数据库
 */
- (BOOL)dbMigrate{
    return [self basicUserDefaults:[NSString stringWithFormat:@"dbMigrate%ld",appBuild]];
}

- (NSString*)formatDate:(NSUInteger)time style:(NSString*)style {
    date = [NSDate dateWithTimeIntervalSince1970:time];
    dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:style];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)flattenHTML:(NSString *)html {
    //    NSLog(@"-----===%@",html);
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    
    //    NSLog(@"-----===%@",html);
    NSCharacterSet *nbsp = [NSCharacterSet characterSetWithCharactersInString:@"&nbsp;"];
    html = [html stringByTrimmingCharactersInSet:nbsp];
    return [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)formatDistance:(float)distance {
    return [NSString stringWithFormat:distance>1000?@"%dkm":@"%dm",(int)roundf(distance>1000?distance/1000:distance)];
}

/**
 *  验证邮箱
 */
- (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  验证手机号
 */
- (BOOL)validatePhone:(NSString *)phone {
    NSString *phoneRegex = @"^1+[3578]+\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //        NSLog(@"phoneTest is %@",phone);
    return [phoneTest evaluateWithObject:phone];
}


@end
