//
//  OrderHeadCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderDetailHeadCell.h"

@implementation OrderDetailHeadCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor UIColorFromRGB:0xeefffc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight
{
    return 70.f;
}

@end
