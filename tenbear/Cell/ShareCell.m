//
//  ShareCell.m
//  tenbear
//
//  Created by fengyibo on 16/3/11.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ShareCell.h"
#import "Constants.h"

@implementation ShareCell

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToTableView)]];
    }
    return _backView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width/2;
    self.headImage.layer.masksToBounds = YES;
//    if (image) {
//        [image drawAtPoint:imagePoint];
//        self.image = nil;
//    }
//    else {
//        [placeHolder drawAtPoint:imagePoint];
//    }
//    [text drawInRect:textRect withFont:font lineBreakMode:UILineBreakModeTailTruncation];
}

- (IBAction)playButtonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(Play:)]) {
        sender.tag = self.tag;
        [_delegate Play:sender];
    }
    
//    [self.window addSubview:self.backView];
//
//    UIImageView *copyImageView = [[UIImageView alloc] init];
//    self.showView = copyImageView;
//    copyImageView.frame = CGRectMake(sender.frame.origin.x, self.frame.origin.y+sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
//    if (sender == self.playButton) {
//        copyImageView.image = self.videoCutImage.image;
//    }
//    else{
//        copyImageView.image = sender.imageView.image;
//    }
//    [self.backView addSubview:copyImageView];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        copyImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, copyImageView.image.size.height/copyImageView.image.size.width*SCREEN_WIDTH);
//        copyImageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
//    }];
}

- (void)backToTableView{
    [self.backView removeFromSuperview];
    [self.showView removeFromSuperview];
}
@end
