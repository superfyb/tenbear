//
//  ConfirmOrderVC.h
//  tenbear
//
//  Created by fengyibo on 16/3/25.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBaseVC : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *payButton;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *closeOrderLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancelOrder;

@end
