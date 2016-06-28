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
    
    [RACObserve(self.geoIcon, hidden) subscribeNext:^(NSNumber* hidden){
        if ([hidden boolValue]) {
            self.addrLabelLeadingConstraint.constant = -12.f;
            
        }
        else {
            self.addrLabelLeadingConstraint.constant = 10.f;
        }
        [self updateFocusIfNeeded];
    }];
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
    if (!addrDto) {
        self.geoIcon.hidden = YES;
        self.nameLabel.text = @"";
        self.phoneNumLabel.text = @"";
        self.addrLabel.text = @"请您先增加收货地址信息";

    }
    else {
        self.geoIcon.hidden = NO;

        self.nameLabel.text = addrDto.contact;
        self.phoneNumLabel.text = addrDto.mobile;
        self.addrLabel.text = [NSString stringWithFormat:@"%@ %@", addrDto.region, addrDto.street];
    }
    
}

-(void)setConsigneeDto:(ConsigneeDTO *)consigneeDto
{
    _consigneeDto = consigneeDto;
    self.nameLabel.text = consigneeDto.name;
    self.phoneNumLabel.text = consigneeDto.mobile;
    if(!_consigneeDto){
        self.addrLabel.text = @"请您先增加自提人信息";

    }
    else {
        self.addrLabel.text = consigneeDto.identity;
    }
}

+(CGFloat)cellHeight
{
    return 110.f;
}

@end
