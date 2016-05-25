//
//  OrderDetailStatusCell.m
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderDetailStatusCell.h"

@implementation OrderDetailStatusCell



- (void)awakeFromNib {
    // Initialization code
    
    self.icon0.backgroundColor = [UIColor UIColorFromRGB:0x0c9145];
    self.icon0.layer.borderColor = ((UIColor*)[UIColor UIColorFromRGB:0x0c9145]).CGColor;
    [self.icon0 roundImageWithBordWidth:4.0 andBordColor:[UIColor whiteColor]];
    self.icon0.clipsToBounds = YES;
    
    self.icon1.backgroundColor = [UIColor UIColorFromRGB:0x666666];
    self.icon1.layer.borderWidth = 0.f;
    self.icon1.layer.borderColor = [UIColor clearColor].CGColor;
    self.icon1.clipsToBounds = YES;


    [self.icon1 roundImageWithBordWidth:4.0 andBordColor:[UIColor whiteColor]];
    
    self.icon2.backgroundColor = [UIColor UIColorFromRGB:0x666666];
    self.icon2.layer.borderWidth = 0.f;
    self.icon2.layer.borderColor = [UIColor clearColor].CGColor;
    self.icon2.clipsToBounds = YES;


    [self.icon2 roundImageWithBordWidth:4.0 andBordColor:[UIColor whiteColor]];
    
    self.icon3.backgroundColor = [UIColor UIColorFromRGB:0x666666];
    self.icon3.layer.borderWidth = 0.f;
    self.icon3.layer.borderColor = [UIColor clearColor].CGColor;
    [self.icon3 roundImageWithBordWidth:4.0 andBordColor:[UIColor whiteColor]];
    self.icon3.clipsToBounds = YES;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
