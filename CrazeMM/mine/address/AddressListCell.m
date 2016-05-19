//
//  AddressListCell.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
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
    
    self.nameLabel.text = @"徐赛";
    self.phoneLabel.text = @"1324324234324";
  
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithAttributedString:[[self class] defaultString]];
    [attrString appendAttributedString:[[self class] addressString:@"江苏省南京市浦口区百润路2号天 润城1-4街区66栋102室"]];
    self.addressLabel.attributedText = attrString;



}

+(NSAttributedString*)defaultString
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"[默认地址]"];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}
                            range:NSMakeRange(0, [@"[默认地址]" length])];
    return attributedText;
}

+(NSAttributedString*)addressString:(NSString*)string
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}
                            range:NSMakeRange(0, [string length])];
    return attributedText;
}

-(void)setAddrDto:(AddressDTO *)addrDto
{
    _addrDto = addrDto;
    self.nameLabel.text = addrDto.contact;
    self.phoneLabel.text = addrDto.mobile;
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithAttributedString:[[self class] defaultString]];
    [attrString appendAttributedString:[[self class]addressString:[NSString stringWithFormat:@"%@ %@", addrDto.region, addrDto.street]]];

    self.addressLabel.attributedText = attrString;
    }


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
