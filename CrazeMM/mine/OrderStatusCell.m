//
//  OrderStatusCell.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderStatusCell.h"

@implementation OrderStatusCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.payButton setTitle:@"待付款" forState:UIControlStateNormal];
    [self.refundCell setTitle:@"退款/仲裁" forState:UIControlStateNormal];
    [self.receiptCell setTitle:@"待签收" forState:UIControlStateNormal];
    
    [self.payButton setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
    [self.refundCell setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
    [self.receiptCell setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];

    [self.payButton setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
    [self.refundCell setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
    [self.receiptCell setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
