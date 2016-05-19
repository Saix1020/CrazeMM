//
//  AccountSummaryCell.m
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AccountSummaryCell.h"

@implementation AccountSummaryCell

- (void)awakeFromNib {
    // Initialization code
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_alpha"]];
    imageView.contentMode = UIViewContentModeCenter ;
    self.clipsToBounds = YES;

    
    self.backgroundView = imageView;
    
    self.amountMoneyLabel.adjustsFontSizeToFitWidth = YES;
    self.aviliableMoney.adjustsFontSizeToFitWidth = YES;
    self.fronzenMoney.adjustsFontSizeToFitWidth = YES;
}

+(CGFloat)cellHeight
{
    return 125.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
