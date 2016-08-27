//
//  AddrDefaultCheckboxCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddrDefaultCheckboxCell.h"

@implementation AddrDefaultCheckboxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.checkBox.on = NO;
    self.checkBox.animationDuration = 0.f;
//    self.clipsToBounds
    self.checkBox2.hidden = YES;
    self.titleLabel2.hidden = YES;
    
    self.checkBox.boxType = BEMBoxTypeSquare;
    self.checkBox2.boxType = BEMBoxTypeSquare;
    self.checkBox.animationDuration = self.checkBox2.animationDuration = 0.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
