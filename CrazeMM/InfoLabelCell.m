//
//  InfoLabelCell.m
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "InfoLabelCell.h"

@implementation InfoLabelCell

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = [UIFont systemFontOfSize:16.f];
        [self.contentView addSubview:_infoLabel];
    }
    
    return _infoLabel;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
//        _titleLabel.textColor = [UIColor UIColorFromRGB:0x444];
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

-(UIView*)seperatorLine
{
    if (!_seperatorLine) {
        _seperatorLine = [[UIView alloc] init];
        _seperatorLine.backgroundColor = [UIColor UIColorFromRGB:0xC8C7CC];
        [self.contentView addSubview:_seperatorLine];
    }
    
    return _seperatorLine;
}


-(void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    [self.infoLabel sizeToFit];
    
    if (self.titleWidth) {
        self.titleLabel.width = self.titleWidth;
    }
    
    self.titleLabel.frame = CGRectMake(16.f, (self.contentView.height-self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
    self.infoLabel.frame = CGRectMake(self.titleLabel.right+16.f, (self.contentView.height-self.infoLabel.height)/2, self.contentView.width-self.titleLabel.right-16.f-8.f, self.infoLabel.height);
    
    self.seperatorLine.frame = CGRectMake(16.f, self.height-1, self.width-16.f, 0.5);
}


@end
