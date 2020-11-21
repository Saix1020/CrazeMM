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
    
    [RACObserve(self.promptLabel, text) subscribeNext:^(id x){
        if (self.promptLabel.text.length == 0) {
            self.promptLabel.hidden = YES;
            self.titleLabelTopConstraint.constant = 14.f;
            [self.contentView setNeedsUpdateConstraints];
        }
        else {
            self.promptLabel.hidden = NO;
            self.titleLabelTopConstraint.constant = 6.f;
            [self.contentView setNeedsUpdateConstraints];

        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitleLabelColor:(UIColor*)color
{
    self.titleLabel.textColor = color;
}

+(CGFloat)cellHeight
{
    return 70.f;
}


@end
