//
//  AddrRegionCell.m
//  CrazeMM
//
//  Created by saix on 16/5/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddrRegionCell.h"

@implementation AddrRegionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.regionLabel.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
