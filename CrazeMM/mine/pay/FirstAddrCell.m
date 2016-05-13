//
//  FirstAddrCell.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "FirstAddrCell.h"

@implementation FirstAddrCell

- (void)awakeFromNib
{
    [self.detailButton setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    self.detailButton.tintColor = [UIColor light_Black_Color];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight
{
    return 110.f;
}

@end
