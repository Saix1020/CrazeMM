//
//  OrderDetailAddrCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddrDTO.h"

@interface OrderDetailAddrCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;

@property (nonatomic, strong) AddrDTO* addrDto;

@end
