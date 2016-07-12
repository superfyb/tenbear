//
//  DynamicDetailsCell.m
//  tenbear
//
//  Created by fengyibo on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "DynamicDetailsCell.h"

@implementation DynamicDetailsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.height/2.0;
    self.headImageView.layer.masksToBounds = YES;
}

@end
