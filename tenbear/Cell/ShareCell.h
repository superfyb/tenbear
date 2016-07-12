//
//  ShareCell.h
//  tenbear
//
//  Created by fengyibo on 16/3/11.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareCellDelegate <NSObject>
- (void)Play:(UIButton *)button;
@end

@interface ShareCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *mainLabel;

@property (assign, nonatomic) CGFloat *CellHeight;
@property (strong, nonatomic) IBOutlet UIButton *praiseButton;//赞
@property (strong, nonatomic) IBOutlet UIButton *discussButton;//评论
@property (strong, nonatomic) IBOutlet UIButton *shareButton;//转发
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIImageView *videoCutImage;//视频封面
@property (strong, nonatomic) UIView *backView;//背景试图
@property (strong, nonatomic) UIImageView *showView;//背景上的ImageView

@property (assign, nonatomic) id<ShareCellDelegate> delegate;
- (IBAction)playButtonClick:(UIButton *)sender;

@end


