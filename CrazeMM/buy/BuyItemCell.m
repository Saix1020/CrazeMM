//
//  BuyItemCell.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyItemCell.h"
#import <objc/runtime.h>

@implementation BuyItemCell

- (void)awakeFromNib
{
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.arrowLable = (UILabel*)self.arrawView;
    self.arrowLable.layer.borderWidth = .5f;
    self.arrowLable.layer.borderColor = [[UIColor greenColor] CGColor];
    self.arrowLable.text = @"求购";
    self.arrowLable.textColor = [UIColor greenColor];
    self.arrowLable.backgroundColor = [UIColor clearColor];
    self.arrowLable.textAlignment = NSTextAlignmentCenter;
    self.arrowLable.font = [UIFont fontWithName:self.arrowLable.font.fontName size:12];
    self.arrowLable.adjustsFontSizeToFitWidth = YES;
    
    //self.titleLabel.text = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    self.detailLabel.text = @"￥1020.00起 10台";
    self.detailLabel.font = [UIFont fontWithName:self.detailLabel.font.fontName size:15.f];
    self.detailLabel.textColor = [UIColor orangeColor];
    self.detailLabel.adjustsFontSizeToFitWidth = YES;

    
    self.leftTimeLabel.backgroundColor = [UIColor UIColorFromRGB:0xF5FFFF];
    self.leftTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.leftTimeLabel.text = @"🕑 10 天 18 小时 20 分钟 10秒";
    self.leftTimeLabel.adjustsFontSizeToFitWidth = YES;

    
    self.phoneImageView.image = [UIImage imageNamed:@"prod_placeholder.jpg"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    self.arrowLable.bounds = self.arrawView.bounds;
//    self.arrowLable.text = @"HHHH";
//}

@end
