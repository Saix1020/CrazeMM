//
//  AddrDetailCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddrDetailCell.h"

@interface AddrDetailCell ()

@property (nonatomic, strong) NSLayoutConstraint* defaultLabelLeadingConstraint;

@end

@implementation AddrDetailCell

- (void)awakeFromNib {
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.phoneLabel.adjustsFontSizeToFitWidth = YES;
    
    self.addressLabel.adjustsFontSizeToFitWidth = YES;
    self.addressLabel.textColor = [UIColor grayColorL2];
    
    self.defaultCheckBox.on = NO;
    self.defaultCheckBox.animationDuration = 0.f;
    self.defaultCheckBox.tintColor = [UIColor grayColorL2];
    self.defaultCheckBox.onCheckColor = [UIColor redColor];
    self.defaultCheckBox.onTintColor = [UIColor redColor];
    
    [self.editButton addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.editButton.tintColor = [UIColor grayColor];
    self.deleteButton.tintColor = [UIColor grayColor];
    
    [self.editButton setImage:[[UIImage imageNamed:@"edit_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.deleteButton setImage:[[UIImage imageNamed:@"delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];

    for (NSLayoutConstraint* constraint in self.contentView.constraints) {
        if(constraint.firstItem == self.defaultLabel
           && constraint.secondItem == self.defaultCheckBox){
            self.defaultLabelLeadingConstraint = constraint;
            break;
        }
            
    }
    
}

-(NSAttributedString*)defaultString
{
    NSString* string = self.addrDto.isDefault? @"[默认地址]" : @"设为默认";
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:string];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:self.addrDto.isDefault?[UIColor redColor]:[UIColor grayColor]}
                            range:NSMakeRange(0, string.length)];
    return attributedText;
}

+(NSAttributedString*)addressString:(NSString*)string
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}
                            range:NSMakeRange(0, [string length])];
    return attributedText;
}

-(void)setAddrDto:(AddrDTO *)addrDto
{
    _addrDto = addrDto;
    self.nameLabel.text = addrDto.contact;
    self.phoneLabel.text = NotNilAndNull(addrDto.phone)? addrDto.phone: addrDto.mobile;
    self.addressLabel.attributedText = [[self class] addressString:[NSString stringWithFormat:@" %@ %@", addrDto.region, addrDto.street]];
    self.defaultCheckBox.on = addrDto.isDefault;
    self.defaultLabel.attributedText = [self defaultString];

    if (addrDto.isDefault) {
         self.defaultCheckBox.hidden = YES;
        self.defaultLabelLeadingConstraint.constant = -16.f;
    }
    else {
        self.defaultCheckBox.hidden = NO;
        self.defaultLabelLeadingConstraint.constant = 4.f;
    }
    [self.contentView updateConstraints];
}

-(void)editAddress:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editButtonClicked:)]) {
        [self.delegate editButtonClicked:self];
    }
}
-(void)deleteAddress:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClicked:)]) {
        [self.delegate deleteButtonClicked:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    }

@end
