//
//  WithDrawLogCell.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WithDrawLogCell.h"

@implementation WithDrawLogCell

-(void)awakeFromNib
{
    self.stateLabel.clipsToBounds = YES;
    self.stateLabel.layer.cornerRadius = 4.f;
    self.stateLabel.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];
    self.stateLabel.textColor = [UIColor UIColorFromRGB:0x3972a2];

}

-(void)setWithDrawLogDto:(WithDrawLogDTO *)withDrawLogDto
{
    _withDrawLogDto = withDrawLogDto;
    
    self.stateLabel.text = [NSString stringWithFormat:@" %@ ", withDrawLogDto.stateLabel];
    self.createTime.text = withDrawLogDto.createTime;
    self.amountLabel.text = [NSString stringWithFormat:@"¥%.02f", withDrawLogDto.amount];
    self.bankDescLabel.text = withDrawLogDto.bankDesc;

}

@end
