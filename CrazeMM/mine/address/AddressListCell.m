//
//  AddressListCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressListCell.h"


@implementation AddressListCell

- (void)awakeFromNib
{

    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.textColor = [UIColor grayColorL2];
    
    self.phoneLabel.adjustsFontSizeToFitWidth = YES;
    self.phoneLabel.textColor = [UIColor grayColorL2];
    
    self.addressLabel.numberOfLines = 2;
    self.addressLabel.adjustsFontSizeToFitWidth = YES;
    self.addressLabel.textColor = [UIColor grayColorL2];
    
    [self.editButton addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(NSAttributedString*)defaultString
{
    NSString* string = self.isDefault? @"[默认地址]" : @"[设为默认地址]";
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:string];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:self.isDefault?[UIColor redColor]:[UIColor blueColor]}
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
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithAttributedString:[self defaultString]];
    [attrString appendAttributedString:[[self class] addressString:[NSString stringWithFormat:@" %@ %@", addrDto.region, addrDto.street]]];
    self.addressLabel.attributedText = attrString;
}

-(void)editAddress:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editButtonClicked:)]) {
        [self.delegate editButtonClicked:self];
    }
}

@end
