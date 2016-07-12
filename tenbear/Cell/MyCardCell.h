//
//  MyCardCell.h
//  tenbear
//
//  Created by fengyibo on 16/3/8.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCardCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cardImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (strong, nonatomic) IBOutlet UIView *backGroundView;

@end
