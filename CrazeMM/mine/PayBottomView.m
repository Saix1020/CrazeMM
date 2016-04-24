//
//  PayBottomView.m
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayBottomView.h"

@implementation PayBottomView

- (void)awakeFromNib {
    
    self.selectAllCheckBox.onCheckColor = [UIColor whiteColor];
    self.selectAllCheckBox.onTintColor = [UIColor redColor];
    self.selectAllCheckBox.onFillColor = [UIColor redColor];
    self.selectAllCheckBox.boxType = BEMBoxTypeCircle;
    self.selectAllCheckBox.on = YES  ;

    [self fomartTotalPriceLabel];
}

-(void)fomartTotalPriceLabel
{
    //self.totalPriceLabel.text = @"总计 ￥10,000,00.00";
    
    self.totalPriceLabel.text = @"";
    self.totalPriceLabel.textAlignment = kCTTextAlignmentRight;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"总计: "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor grayColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"10,000,00"];
    
    if (attributedText.length > 9) {
        [attributedText m80_setFont:[UIFont boldSystemFontOfSize:14.f]];
    }
    else {
        [attributedText m80_setFont:[UIFont boldSystemFontOfSize:16.f]];
    }
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@".00"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    [self.totalPriceLabel appendText:@""];
    self.totalPriceLabel.numberOfLines = 1;
    self.totalPriceLabel.offsetY = -4.f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight
{
    return 40.f;
}

@end
