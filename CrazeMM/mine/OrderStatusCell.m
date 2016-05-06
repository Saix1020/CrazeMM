//
//  OrderStatusCell.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderStatusCell.h"
#import "UIView+Utils.h"
#import "NSAttributedString+Utils.h"
@implementation OrderStatusCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor UIColorFromRGB:0xfff3f3];
    
//    UILabel* label = [[UILabel alloc] init];
//    label.font = [UIFont systemFontOfSize:12.f];
//    label.textColor = [UIColor dark_Gray_Color];
//    label.text = @"待付款";
//    [label sizeToFit];
//    self.payButton.tintColor = [UIColor blackColor];
//    [self.payButton setImage:[label imageForView] forState:UIControlStateNormal];
//    [self.payButton setTitle:@"(10)" forState:UIControlStateNormal];
//
////    self.payButton.imageEdgeInsets = UIEdgeInsetsMake(0, label.width/2, 0, label.width/2);
////    self.payButton.titleEdgeInsets = UIEdgeInsetsMake(0, label.width/2, 0, label.width/2);
//    label.text = @"退款/仲裁";
//    [label sizeToFit];
//    self.refundCell.tintColor = [UIColor blackColor];
//    [self.refundCell setImage:[label imageForView] forState:UIControlStateNormal];
////    [self.refundCell setTitle:@"(10)" forState:UIControlStateNormal];
//
//    label.text = @"待签收";
//    [label sizeToFit];
//    self.receiptCell.tintColor = [UIColor blackColor];
//    [self.receiptCell setImage:[label imageForView] forState:UIControlStateNormal];
//    [self.receiptCell setTitle:@"(0)" forState:UIControlStateNormal];
//
//    
//    [self.refundCell setTitle:@"" forState:UIControlStateNormal];
////    [self.receiptCell setTitle:@"待签收" forState:UIControlStateNormal];
////    
//    
//    
//    
//    [self.payButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.refundCell setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
//    [self.receiptCell setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//
//    [self.payButton setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
//    [self.refundCell setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
//    [self.receiptCell setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
//    
//    self.button1 = self.payButton;
//    self.button2 = self.re
    
    self.button1.tintColor = [UIColor blackColor];
    self.button2.tintColor = [UIColor blackColor];
    self.button3.tintColor = [UIColor blackColor];
    
    self.titleArray = @[@{@"name" : @"待付款", @"number" : @(10)},
                        @{@"name" : @"待签收", @"number" : @(10)},
                        @{@"name" : @"其他", @"number" : @(0)}];
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    for (int i=0; i<titleArray.count; ++i) {
        UIButton* button;
        switch (i) {
            case 0:
                button = self.button1;
                break;
            case 1:
                button = self.button2;
                break;
            default:
                button = self.button3;
                break;
        }
        
        NSDictionary* dict = titleArray[i];
        NSInteger number = [dict[@"number"] integerValue];
        NSString* name = dict[@"name"];
        
        if (number>=0) {
            NSArray* stringWithAttrs = @[
                                         @{
                                             @"string" : name,
                                             @"attributes" : @{
                                                     NSForegroundColorAttributeName : [UIColor dark_Gray_Color],
                                                     NSFontAttributeName : [UIFont systemFontOfSize:12.f]
                                                     }
                                             },
                                         @{
                                             @"string" : [NSString stringWithFormat:@" (%ld)", number],
                                             @"attributes" : @{
                                                     NSForegroundColorAttributeName : [UIColor redColor],
                                                     NSFontAttributeName : [UIFont systemFontOfSize:12.f]
                                                     }
                                             }
                                         ];
            NSAttributedString* attributedString = [NSAttributedString composedAttributedString:stringWithAttrs];
            [button setAttributedTitle:attributedString forState:UIControlStateNormal];
        }
        else{
            [button setAttributedTitle:nil forState:UIControlStateNormal];
            [button setTitle:name forState:UIControlStateNormal];
            [button setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];

        }

    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
