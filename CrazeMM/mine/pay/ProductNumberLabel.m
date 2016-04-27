//
//  ProductNumberLabel.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductNumberLabel.h"

@implementation ProductNumberLabel


-(void)awakeFromNib
{
    self.numberLabel.numberOfLines = 1;
    self.numberLabel.adjustsFontSizeToFitWidth = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
