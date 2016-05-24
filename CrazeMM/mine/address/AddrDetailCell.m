//
//  AddrDetailCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddrDetailCell.h"

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
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] init];
    [attrString appendAttributedString:[[self class] addressString:[NSString stringWithFormat:@" %@ %@", addrDto.region, addrDto.street]]];
    self.addressLabel.attributedText = attrString;
    self.defaultCheckBox.on = addrDto.isDefault;
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

@end
