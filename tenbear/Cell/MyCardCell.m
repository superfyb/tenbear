//
//  MyCardCell.m
//  tenbear
//
//  Created by fengyibo on 16/3/8.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "MyCardCell.h"

@implementation MyCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backGroundView.layer.cornerRadius = 5;
    self.cardImageView.layer.cornerRadius = self.cardImageView.frame.size.height/2.0;
    self.backGroundView.layer.masksToBounds = YES;
    self.cardImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
