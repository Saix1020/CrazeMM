//
//  CustomSeperatorLineCell.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CustomSeperatorLineCell.h"

@interface CustomSeperatorLineCell()

@end

@implementation CustomSeperatorLineCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier enableTopLine:(BOOL)top enableButtomLine:(BOOL)buttom
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.enableTopLine = top;
        self.enableButtomLine = buttom;
    }
    
    return self;
}


-(UIView*)topSeperatorLine
{
    if(!_topSeperatorLine){
        _topSeperatorLine = [[UIView alloc] init];
        [self.contentView addSubview:_topSeperatorLine];
        _topSeperatorLine.layer.borderWidth = 0.5;
        _topSeperatorLine.layer.borderColor = RGBCOLOR(205, 205, 205).CGColor;
    }
    return _topSeperatorLine;
}

-(UIView*)buttomSeperatorLine
{
    if(!_buttomSeperatorLine){
        _buttomSeperatorLine = [[UIView alloc] init];
        _buttomSeperatorLine.layer.borderWidth = 0.5;
        _buttomSeperatorLine.layer.borderColor = RGBCOLOR(205, 205, 205).CGColor;
        
        [self.contentView addSubview:_buttomSeperatorLine];
    }
    return _buttomSeperatorLine;
}

-(void)setEnableTopLine:(BOOL)enableTopLine
{
    _enableTopLine = enableTopLine;
//    if (_enableTopLine) {
//        self.topSeperatorLine.frame = CGRectMake(kHeadAlign, 0, self.contentView.bounds.size.width-kHeadAlign, 1.f);
//    }
//    else {
//        self.topSeperatorLine.frame = CGRectMake(kHeadAlign, 0, self.contentView.bounds.size.width-kHeadAlign, 0.f);
//    }
}

-(void)setEnableButtomLine:(BOOL)enableButtomLine
{
    _enableButtomLine = enableButtomLine;
//    if (_enableButtomLine) {
//        self.buttomSeperatorLine.frame = CGRectMake(kHeadAlign, 0, self.contentView.bounds.size.width-kHeadAlign, 1.f);
//    }
//    else {
//        self.buttomSeperatorLine.frame = CGRectMake(kHeadAlign, 0, self.contentView.bounds.size.width-kHeadAlign, 0.f);
//    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.enableTopLine){
        self.topSeperatorLine.frame = CGRectMake(kHeadAlign, 0, self.contentView.bounds.size.width-kHeadAlign, 1.f);
    }
    else {
        self.topSeperatorLine.frame = CGRectMake(kHeadAlign, 0, self.contentView.bounds.size.width-kHeadAlign, 0.f);

    }
    
    if(self.enableButtomLine){
        self.buttomSeperatorLine.frame = CGRectMake(kHeadAlign, self.contentView.bounds.size.height-1.f, self.contentView.bounds.size.width-kHeadAlign, 1.f);

    }
    else {
        self.buttomSeperatorLine.frame = CGRectMake(kHeadAlign, 0, self.contentView.bounds.size.width-kHeadAlign, 0.f);

    }
}


@end
