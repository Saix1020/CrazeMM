//
//  PayAlertView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayAlertView.h"

@implementation PayAlertView

-(void)awakeFromNib
{
//    [self.dismissButton setImage:[UIImage imageNamed:@"cancel_m"] forState:UIControlStateNormal];
    self.dismissButton.tintColor = [UIColor light_Gray_Color];
    
//    [self fomartTotalMoneyLabel];
//    self.sumLabel.textAlignment = kCTTextAlignmentCenter;
    
    self.line.backgroundColor = [UIColor clearColor];
    self.line.layer.borderWidth = .5f;
    self.line.layer.borderColor = [UIColor light_Gray_Color].CGColor;
}

//-(void)fomartTotalMoneyLabel
//{
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
//    [attributedText m80_setFont:[UIFont boldSystemFontOfSize:14.f]];
//    [attributedText m80_setTextColor:[UIColor blackColor]];
//    [self.sumLabel appendAttributedText:attributedText];
//    
//    attributedText = [[NSMutableAttributedString alloc]initWithString:@"10,000,00"];
//    [attributedText m80_setFont:[UIFont boldSystemFontOfSize:18.f]];
//    [attributedText m80_setTextColor:[UIColor blackColor]];
//    [self.sumLabel appendAttributedText:attributedText];
//    
//    attributedText = [[NSMutableAttributedString alloc]initWithString:@".00"];
//    [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
//    [attributedText m80_setTextColor:[UIColor blackColor]];
//    [self.sumLabel appendAttributedText:attributedText];
//}

@end
