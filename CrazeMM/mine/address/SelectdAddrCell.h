//
//  SelectdAddrCell.h
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDTO.h"

// call me RecommandCell!!
@interface SelectdAddrCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *companyAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong) AddressDTO* addressDto;

@end
