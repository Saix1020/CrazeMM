//
//  OrderStatusCell.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderStatusCell.h"
#import "UIView+Utils.h"

@implementation OrderStatusCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor UIColorFromRGB:0xfff3f3];
    
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12.f];
    label.textColor = [UIColor dark_Gray_Color];
    label.text = @"待付款";
    [label sizeToFit];
    self.payButton.tintColor = [UIColor blackColor];
    [self.payButton setImage:[label imageForView] forState:UIControlStateNormal];
    [self.payButton setTitle:@"(10)" forState:UIControlStateNormal];

//    self.payButton.imageEdgeInsets = UIEdgeInsetsMake(0, label.width/2, 0, label.width/2);
//    self.payButton.titleEdgeInsets = UIEdgeInsetsMake(0, label.width/2, 0, label.width/2);
    label.text = @"退款/仲裁";
    [label sizeToFit];
    self.refundCell.tintColor = [UIColor blackColor];
    [self.refundCell setImage:[label imageForView] forState:UIControlStateNormal];
//    [self.refundCell setTitle:@"(10)" forState:UIControlStateNormal];

    label.text = @"待签收";
    [label sizeToFit];
    self.receiptCell.tintColor = [UIColor blackColor];
    [self.receiptCell setImage:[label imageForView] forState:UIControlStateNormal];
    [self.receiptCell setTitle:@"(0)" forState:UIControlStateNormal];

    
    [self.refundCell setTitle:@"" forState:UIControlStateNormal];
//    [self.receiptCell setTitle:@"待签收" forState:UIControlStateNormal];
//    
    
    
    
    [self.payButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.refundCell setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
    [self.receiptCell setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [self.payButton setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
    [self.refundCell setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
    [self.receiptCell setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
    
    //self.payButton.titleLabel.font =

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
