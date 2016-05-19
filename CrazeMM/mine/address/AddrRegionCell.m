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
    
    CGSize fontSize = [self.chooseButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.chooseButton.titleLabel.font}];
    [self.chooseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.chooseButton.imageView.frame.size.width-2.f, 0, self.chooseButton.imageView.frame.size.width+2.f)];
    [self.chooseButton setImageEdgeInsets:UIEdgeInsetsMake(0, fontSize.width, 0, -fontSize.width)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
