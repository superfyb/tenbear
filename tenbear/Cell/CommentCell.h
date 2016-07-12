//
//  CommentCell.h
//  tenbear
//
//  Created by 黄达能 on 16/3/25.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIView *commentImageView;
@property (assign,nonatomic) BOOL isHaveCommentImage;
@property (assign,nonatomic) int commentImageNum;

@end
