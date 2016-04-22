//
//  BuyItemCell.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyItemCell.h"
#import <objc/runtime.h>

@interface BuyItemCell()

@end

@implementation BuyItemCell

- (void)awakeFromNib
{
    [self commInit];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commInit];

    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commInit];

    }
    
    return self;
}

-(void)commInit
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //self.arrawView.textLabel.text = @"求购";
    
    //self.titleLabel.text = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    self.detailLabel.text = @"￥1020.00起 10台";
    self.detailLabel.font = [UIFont fontWithName:self.detailLabel.font.fontName size:15.f];
    self.detailLabel.textColor = [UIColor orangeColor];
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    
    
    self.leftTimeLabel.backgroundColor = [UIColor lightGrayColor188];
    self.leftTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.leftTimeLabel.text = @"🕑 10 天 18 小时 20 分钟";
    self.leftTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    
    self.phoneImageView.image = [UIImage imageNamed:@"prod_placeholder.jpg"];
    self.phoneImageView.layer.borderWidth = 1;
    self.phoneImageView.layer.borderColor = [UIColor lightGrayColor188].CGColor;
    
    self.bottomLine.layer.borderWidth = 0.5;
    self.bottomLine.layer.borderColor = [UIColor lightGrayColor188].CGColor;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArrawString:(NSString *)arrawString
{
    self.arrawView.textLabel.text = arrawString;
}

-(NSString*)arrawString
{
    return self.arrawView.textLabel.text;
}

+(CGFloat)cellHeight
{
    return 140.f;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //self.bottomLine.frame = CGRectMake(8.f, self.bottom, self.width-2*8.f, 1);
}

@end
