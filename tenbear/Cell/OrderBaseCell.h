//
//  OrderBaseCell.h
//  tenbear
//
//  Created by fengyibo on 16/3/29.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderView.h"

@interface OrderBaseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (assign, nonatomic) NSInteger *goodsNum;
@end
