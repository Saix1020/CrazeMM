//
//  FirstAddrCell.h
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDTO.h"
#import "ConsigneeDTO.h"

@interface FirstAddrCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UIImageView *geoIcon;

@property (nonatomic, strong) AddressDTO* addrDto;
@property (nonatomic, strong) ConsigneeDTO* consigneeDto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addrLabelLeadingConstraint;

+(CGFloat)cellHeight;

@end
