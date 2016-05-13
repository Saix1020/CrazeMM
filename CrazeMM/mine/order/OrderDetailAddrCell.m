//
//  OrderDetailAddrCell.m
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderDetailAddrCell.h"

@implementation OrderDetailAddrCell

- (void)awakeFromNib {
    // Initialization code
    self.icon.tintColor = [UIColor light_Gray_Color];
    self.icon.image = [[UIImage imageNamed:@"addr"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
}

-(void)setAddrDto:(AddrDTO *)addrDto
{
    _addrDto = addrDto;
    if (addrDto) {
        self.nameLabel.text = [NSString stringWithFormat:@"收货人: %@", addrDto.contact];
        self.phoneLabel.text = addrDto.mobile;
        self.addrLabel.text = [NSString stringWithFormat:@"%@ %@", addrDto.region, addrDto.street];
    }
    else {
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
