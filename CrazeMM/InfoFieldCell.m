//
//  InfoFieldCell.m
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "InfoFieldCell.h"

@implementation InfoFieldCell

-(UITextField*)infoField
{
    if (!_infoField) {
        _infoField = [[UITextField alloc] init];
        _infoField.font = [UIFont systemFontOfSize:16.f];
        [self.contentView addSubview:_infoField];
    }
    
    return _infoField;
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

-(TimeoutButton*)button
{
    if (!_button) {
        _button = [TimeoutButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"获取" forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        
        _button.layer.cornerRadius = 4.f;
        _button.clipsToBounds = YES;
        _button.backgroundColor = [UIColor buttonEnableBackgroundColor];
        [_button setTitleColor:[UIColor buttonEnableTextColor] forState:UIControlStateNormal];
        
        _button.timeoutSeconds = 120;
        _button.enableTitle = @"获取";
        _button.disableTitle = @"秒后重新获取";
        
        [_button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
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
    
    if (self.titleWidth) {
        self.titleLabel.width = self.titleWidth;
    }
    
    self.titleLabel.frame = CGRectMake(16.f, (self.contentView.height-self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
    
    if(!self.needButton){
        self.infoField.frame = CGRectMake(self.titleLabel.right+16.f, (self.contentView.height-self.titleLabel.height)/2, self.contentView.width-self.infoField.right-16.f-8.f, self.titleLabel.height);
    }
    else {
        [self.button sizeToFit];
        self.button.width = self.button.width+8.f;
        self.button.height = self.titleLabel.height + 8.f;
        self.button.x = self.contentView.width - 8.f - self.button.width;
        self.button.y = (self.contentView.height-self.button.height)/2;
        
        self.infoField.x = self.titleLabel.right+16.f;
        self.infoField.height = self.titleLabel.height;
        self.infoField.y = (self.contentView.height-self.infoField.height)/2;
        self.infoField.width = self.button.x - 8.f - self.infoField.x;
        
    }
    
    self.seperatorLine.frame = CGRectMake(16.f, self.height-1, self.width-16.f, 0.5);

}

-(void)clicked:(id)button
{
    [self setNeedsLayout];
}

@end
