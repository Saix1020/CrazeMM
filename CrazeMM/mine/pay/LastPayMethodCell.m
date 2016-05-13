//
//  LastPayMethodCell.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "LastPayMethodCell.h"

@implementation LastPayMethodCell

- (void)awakeFromNib {
    
    [self.accessoryButton setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    self.accessoryButton.tintColor = [UIColor light_Black_Color];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight
{
    return 44.f;
}

@end
