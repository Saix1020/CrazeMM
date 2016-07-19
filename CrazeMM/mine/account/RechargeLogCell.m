//
//  RechargeLogCell.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "RechargeLogCell.h"

@implementation RechargeLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.stateDescLabel.clipsToBounds = YES;
    self.stateDescLabel.layer.cornerRadius = 4.f;
    self.stateDescLabel.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];
    self.stateDescLabel.textColor = [UIColor UIColorFromRGB:0x3972a2];
    
}

-(void)setRechargeLogDto:(RechargeLogDTO *)rechargeLogDto
{
    _rechargeLogDto = rechargeLogDto;
    
    self.stateDescLabel.text = [NSString stringWithFormat:@" %@ ", rechargeLogDto.stateDesc];
    self.createTimeLabel.text = rechargeLogDto.createTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.02f", rechargeLogDto.money];
    self.methodDescLabel.text = [NSString stringWithFormat:@"充值方式: %@", rechargeLogDto.methodDesc];
}

@end
