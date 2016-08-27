//
//  AvataCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AvataCell.h"
#import "CDFInitialsAvatar.h"

@implementation AvataCell

-(void)awakeFromNib
{
    self.selectionStyle =  UITableViewCellSelectionStyleNone;

    [self.avataImageView roundImageWithBordWidth:3.0 andBordColor:[UIColor UIColorFromRGB:0x4bb8f1]];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_alpha"]];
    [self.avataImageView setImageWithURL:[NSURL URLWithString: COMB_URL(@"/ui/img/person-200-200.jpg")] placeholderImage:[@"background_alpha" image]];
    imageView.contentMode = UIViewContentModeCenter ;
    
    self.backgroundView = imageView;
    self.clipsToBounds = YES;
    
    self.nameLabel.text = @"";
    self.moneyLabel.text = @"";
    self.frozenLabel.text = @"";
}

-(void)setMoney:(CGFloat)money
{
    _money = money;
    self.moneyLabel.text = [NSString stringWithFormat:@"账户可用余额: %.02f元", money];
}

-(void)setFrozenMoney:(CGFloat)frozenMoney
{
    _frozenMoney = frozenMoney;
    self.frozenLabel.text = [NSString stringWithFormat:@"账户冻结余额: %.02f元", _frozenMoney];

}

@end
