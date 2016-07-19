//
//  ConsigneeCell.m
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ConsigneeCell.h"

@implementation ConsigneeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.mobileLabel.adjustsFontSizeToFitWidth = YES;
    
    self.identityLabel.adjustsFontSizeToFitWidth = YES;
    self.identityLabel.textColor = [UIColor grayColorL2];
    
    [self.editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.removeButton addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    
    self.editButton.tintColor = [UIColor grayColor];
    self.removeButton.tintColor = [UIColor grayColor];
    
    [self.editButton setImage:[[UIImage imageNamed:@"edit_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.removeButton setImage:[[UIImage imageNamed:@"delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)edit:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editButtonClicked:)]) {
        [self.delegate editButtonClicked:self];
    }
}

-(void)remove:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(removeButtonClicked:)]) {
        [self.delegate removeButtonClicked:self];
    }
}

-(void)setConsigneeDto:(ConsigneeDTO *)consigneeDto
{
    _consigneeDto = consigneeDto;
    self.nameLabel.text = consigneeDto.name;
    self.mobileLabel.text = consigneeDto.mobile;
    self.identityLabel.text = consigneeDto.identity;
}

+(CGFloat)cellHeight
{
    return 128.f;
}

@end
