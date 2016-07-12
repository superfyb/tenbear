//
//  ShoppingCarCell.m
//  tenbear
//
//  Created by fengyibo on 16/3/9.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ShoppingCarCell.h"

@implementation ShoppingCarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)selectButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
