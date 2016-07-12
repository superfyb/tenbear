//
//  MyPartnerCell.m
//  tenbear
//
//  Created by fengyibo on 16/3/9.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "MyPartnerCell.h"

@implementation MyPartnerCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headimageView.layer.cornerRadius = self.headimageView.bounds.size.height/2.0;
    self.headimageView.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
