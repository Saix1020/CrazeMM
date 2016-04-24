//
//  AvataCell.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AvataCell.h"
#import "CDFInitialsAvatar.h"

@implementation AvataCell

-(void)awakeFromNib
{
    self.selectionStyle =  UITableViewCellSelectionStyleNone;

    [self.avataImageView roundImageWithBordWidth:3.0 andBordColor:[UIColor UIColorFromRGB:0x4bb8f1]];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_bg"]];
    
    self.nameLabel.text = @"疯狂的兔子";
    self.moneyLabel.text = @"账户可用余额: 8000元";
    self.frozenLabel.text = @"账户冻结余额: 8000元";
}


@end
