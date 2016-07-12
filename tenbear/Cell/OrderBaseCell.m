//
//  OrderBaseCell.m
//  tenbear
//
//  Created by fengyibo on 16/3/29.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "OrderBaseCell.h"
#import "OrderView.h"
#import "Constants.h"

@implementation OrderBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*(int)self.goodsNum/3);
    for (NSInteger i=0; i<(int)self.goodsNum; i++) {
        OrderView *view = [[NSBundle mainBundle] loadNibNamed:@"OrderView" owner:self options:nil].lastObject;
        view.frame = CGRectMake(0,SCREEN_WIDTH/3*i, SCREEN_WIDTH, SCREEN_WIDTH/3);
        [self.headView addSubview:view];
        NSLog(@"height%lf",view.frame.size.height);
    }
}

@end