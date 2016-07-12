//
//  TextField.m
//  tenbear
//
//  Created by 黄达能 on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "TextField.h"
@interface TextField()
{
    UIButton *testGetCode;
}
@end
@implementation TextField

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //在textfield添加下划线
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-5, frame.size.width, 2)];
        line.backgroundColor = Gray;
        [self addSubview:line];
        //设置文本框左边的view
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
-(TextField *)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeHolder
{
    self.placeholder = placeHolder;
    return [self initWithFrame:frame];
}
-(TextField *)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeHolder withFont:(CGFloat)font
{
    NSDictionary *dic = @{NSForegroundColorAttributeName:FontColor,NSFontAttributeName:[UIFont systemFontOfSize:font]};
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeHolder attributes:dic];
    self.font = [UIFont fontWithName:@"Thonburi" size:font];
    return [self initWithFrame:frame withPlaceHolder:placeHolder];
}
-(TextField *)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeHolder withFont:(CGFloat)font withCountDown:(int)time
{
    //设置textfiled的右视图
    UIView *rightMode = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, frame.size.height)];
    testGetCode = [UIButton buttonWithType:UIButtonTypeCustom];
    testGetCode.frame = CGRectMake(5, 0, 75, frame.size.height);
    [testGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [testGetCode setTitleColor:FontColor forState:UIControlStateNormal];
    testGetCode.titleLabel.font = [UIFont systemFontOfSize:10];
    testGetCode.titleLabel.textAlignment = NSTextAlignmentLeft;
    [testGetCode addTarget:self action:@selector(countDown:) forControlEvents:UIControlEventTouchUpInside];
    testGetCode.tag = time;
    [rightMode addSubview:testGetCode];
    //灰色竖线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,10, 2, frame.size.height/2.5)];
    line.backgroundColor = Gray;
    [rightMode addSubview:line];
    self.rightView = rightMode ;
    self.rightViewMode = UITextFieldViewModeAlways;

    
    return [self initWithFrame:frame withPlaceHolder:placeHolder withFont:font];
}
-(void)countDown:(UIButton *)btn
{
    self.getTestCode();
    //实现倒计时
    btn.enabled = NO;
    __block int timeout = (int)btn.tag;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<0) {//倒计时结束
            dispatch_async(dispatch_get_main_queue(), ^{
                btn.enabled = YES;
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
            
            dispatch_source_cancel(_timer);
            }else{
            NSString *strTime = [NSString stringWithFormat:@"%ds后重新获取",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [testGetCode setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
        
    });
    dispatch_resume(_timer);
}
@end
