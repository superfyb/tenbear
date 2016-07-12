//
//  CommentCell.m
//  tenbear
//
//  Created by 黄达能 on 16/3/25.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "CommentCell.h"
#import "Constants.h"
@implementation CommentCell
//addSubview会触发layoutSubviews。
//设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化。
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_isHaveCommentImage) {
        CGFloat spaceX = 10;
        CGFloat spaceY = 5;
        CGFloat width = 60;
        CGFloat height = 60;
        for (int i = 0; i < _commentImageNum; i++) {
            UIImageView *commentImage = [[UIImageView alloc]initWithFrame:CGRectMake(spaceX * (i%3+1)+width*(i%3), spaceY*(i/3+1)+height*(i/3), width, height)];
            [_commentImageView addSubview:commentImage];
            commentImage.backgroundColor = [UIColor yellowColor];
        }
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
