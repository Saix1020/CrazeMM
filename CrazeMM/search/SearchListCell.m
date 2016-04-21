//
//  SearchListCell.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchListCell.h"


@implementation SearchListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andResultItem:(NSUInteger) item
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initAllSubviews];
    }
    
    return self;
}

-(void)initAllSubviews
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.text = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = [UIFont systemFontOfSize:17];
    self.priceLabel.numberOfLines = 1;
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.text = @"￥1020.00起 10台";

    
    self.seperatorLine = [[UIView alloc] init];
    self.seperatorLine.layer.borderWidth = .25f;
    self.seperatorLine.layer.borderColor = RGBCOLOR(240, 240, 240).CGColor;
//    self.seperatorLine.alpha = .25f;
    
    
    self.arrivalTime = [[UILabel alloc] init];
    self.arrivalTime.font = [UIFont systemFontOfSize:13];
    self.arrivalTime.numberOfLines = 1;
    self.arrivalTime.adjustsFontSizeToFitWidth = YES;
    self.arrivalTime.textColor = RGBCOLOR(131, 131, 131);
    self.arrivalTime.text = @"到货周期:24小时";
    
    
    self.scopeLabel = [[UILabel alloc] init];
    self.scopeLabel.font = [UIFont systemFontOfSize:13];
    self.scopeLabel.numberOfLines = 1;
    self.scopeLabel.adjustsFontSizeToFitWidth = YES;
    self.scopeLabel.textColor = RGBCOLOR(131, 131, 131);
    self.scopeLabel.text = @"供货范围: 北京,北京,北京,北京,北京";

    self.companyLabel = [[UILabel alloc] init];
    self.companyLabel.font = [UIFont systemFontOfSize:15];
    self.companyLabel.numberOfLines = 1;
    self.companyLabel.adjustsFontSizeToFitWidth = YES;
    self.companyLabel.text = @"江苏梁晶信息技术有限公司";
    self.companyLabel.textColor = RGBCOLOR(50, 50, 50);
//    self.scopeLabel.textColor = RGBCOLOR(131, 131, 131);
    
    self.leftTimeLabel = [[UILabel alloc] init];
    self.leftTimeLabel.font = [UIFont systemFontOfSize:13];
    self.leftTimeLabel.numberOfLines = 1;
    self.leftTimeLabel.adjustsFontSizeToFitWidth = YES;
    self.leftTimeLabel.backgroundColor = [UIColor UIColorFromRGB:0xF5FFFF];
    self.leftTimeLabel.text = @"🕑10天18小时20分钟";
    self.leftTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.numberOfLines = 1;
    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    self.typeLabel.textColor = [UIColor greenColor];
    self.typeLabel.layer.borderWidth = .5f;
    self.typeLabel.layer.borderColor = [UIColor greenColor].CGColor;
    self.typeLabel.text = @"求购";
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray* titles = @[@"浏览:10", @"成交:2"];
    self.previewAndTransctionsLabels = [[LabelWithSeperatorLine alloc] init];
    self.previewAndTransctionsLabels.strings = titles;
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.seperatorLine];
    [self.contentView addSubview:self.arrivalTime];
    [self.contentView addSubview:self.companyLabel];
    [self.contentView addSubview:self.scopeLabel];
    [self.contentView addSubview:self.leftTimeLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.previewAndTransctionsLabels];
    
    [self layoutAllLabels];
}

-(void)layoutAllLabels
{
    [self.priceLabel sizeToFit];
    [self.typeLabel sizeToFit];
    
    CGRect bounds = self.contentView.bounds;
    bounds.size.width = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = 16.f;
    self.previewAndTransctionsLabels.frame = CGRectMake(bounds.size.width-70-16.f, y, 70, 60);
    self.titleLabel.frame = CGRectMake(16.f, y,
                                       bounds.size.width-70-16.f*2, 60.f);
    y += self.titleLabel.frame.size.height;
    
    
    self.priceLabel.frame = CGRectMake(16.f, y,
                                       self.priceLabel.frame.size.width, 30.f);
    self.typeLabel.frame = CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+4.f, self.priceLabel.center.y - self.typeLabel.frame.size.height/2,
                                      self.typeLabel.frame.size.width+16.f, self.typeLabel.frame.size.height);
    y += self.priceLabel.frame.size.height+12.f;
    
    self.seperatorLine.frame = CGRectMake(16.f, y, bounds.size.width-2*16.f, 1);
    
    y += self.seperatorLine.frame.size.height+12.f;
    self.arrivalTime.frame = CGRectMake(16.f, y,
                                        bounds.size.width-2*16.f, 24.f);
    
    y += self.arrivalTime.frame.size.height;
    self.scopeLabel.frame = CGRectMake(16.f, y,
                                       bounds.size.width-2*16.f, 24.f);
    
    y += self.scopeLabel.frame.size.height + 6.f;
    
    self.leftTimeLabel.frame =CGRectMake(bounds.size.width-150.f, y,
                                         150.f, 24.f);
    
    
    self.companyLabel.frame = CGRectMake(16.f, y,
                                         bounds.size.width-2*16.f-150.f, 24.f);

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

+(CGFloat)cellHeight
{
    return 210.f;
}


@end
