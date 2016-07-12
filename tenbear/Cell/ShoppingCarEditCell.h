//
//  ShoppingCarEditCell.h
//  tenbear
//
//  Created by fengyibo on 16/3/10.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarEditCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;
- (IBAction)reduceButtonClick:(UIButton *)sender;
- (IBAction)addButtonClick:(UIButton *)sender;
- (IBAction)selectButtonClick:(UIButton *)sender;

@end
