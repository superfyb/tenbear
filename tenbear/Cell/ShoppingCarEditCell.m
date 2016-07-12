//
//  ShoppingCarEditCell.m
//  tenbear
//
//  Created by fengyibo on 16/3/10.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "ShoppingCarEditCell.h"

@implementation ShoppingCarEditCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 减少宝贝数量
- (IBAction)reduceButtonClick:(UIButton *)sender {
    //当宝贝数量为1时，数量不能再减少
    if ([self.numLabel.text isEqualToString:@"1"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"宝贝不能再减少了" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancel];
        [[self viewController] presentViewController:alertController animated:YES completion:nil];
    }
    else{
        self.numLabel.text = [NSString stringWithFormat:@"%d",[self.numLabel.text intValue] - 1];
    }
}

#pragma mark - 增加宝贝数量
- (IBAction)addButtonClick:(UIButton *)sender {
    self.numLabel.text = [NSString stringWithFormat:@"%d",[self.numLabel.text intValue] + 1];
}

#pragma mark - 勾选事件
- (IBAction)selectButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}


@end
