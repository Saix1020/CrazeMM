//
//  ProductMiddleCell.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductMiddleCell.h"

@implementation ProductMiddleCell

//@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
//@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
//@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
//@property (weak, nonatomic) IBOutlet UIButton *moreDetailButton;
//@property (weak, nonatomic) IBOutlet UIImageView *star3;
//@property (weak, nonatomic) IBOutlet UIImageView *star4;
//@property (weak, nonatomic) IBOutlet UIImageView *star5;
//
//@property (weak, nonatomic) IBOutlet UIImageView *start2;
//@property (weak, nonatomic) IBOutlet UIButton *authedButton;
//@property (weak, nonatomic) IBOutlet UIImageView *star1;
//@property (weak, nonatomic) IBOutlet UIButton *contactButton;


- (void)awakeFromNib
{
    self.authedButton.tintColor = [UIColor greenTextColor];
    [self.authedButton setImage:[UIImage imageNamed:@"checked-1"] forState:UIControlStateNormal];
    self.authedButton.tintColor = [UIColor grayColorL2];
    [self.moreDetailButton setImage:[UIImage imageNamed:@"rightR"] forState:UIControlStateNormal];
    
    self.companyNameLabel.adjustsFontSizeToFitWidth = YES;
    self.locationLabel.adjustsFontSizeToFitWidth = YES;
    self.companyNameLabel.textColor = [UIColor grayColorL2];
    self.locationLabel.textColor = [UIColor grayColorL2];
    self.levelLabel.textColor = [UIColor grayColorL2];
    
    self.contactButton.tintColor = [UIColor grayColorL2];
    self.contactButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10.f, 0, 10.f);
    [self.contactButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [self.contactButton setTitle:@"给我留言" forState:UIControlStateNormal];
    [self.contactButton setTitleColor:[UIColor grayColorL2] forState:UIControlStateNormal];
    
    self.contactButton.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.contactButton.layer.borderWidth = .5f;
    self.contactButton.layer.cornerRadius = 4.f;
    
    self.moreDetailButton.tintColor = [UIColor grayColorL2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight
{
    return 165.f;
}

@end
