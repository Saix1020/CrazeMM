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

//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
//@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
//@property (weak, nonatomic) IBOutlet UIButton *detailButton;


-(void)setAddrDto:(AddressDTO *)addrDto
{
    _addrDto = addrDto;
    self.nameLabel.text = addrDto.contact;
    self.phoneNumLabel.text = addrDto.mobile;
    self.addrLabel.text = [NSString stringWithFormat:@"%@ %@", addrDto.region, addrDto.street];
}

+(CGFloat)cellHeight
{
    return 110.f;
}

@end
