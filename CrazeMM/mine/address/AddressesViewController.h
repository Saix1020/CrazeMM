//
//  AddressesViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddrDetailCell.h"

@interface AddressesViewController : UIViewController<UITableViewDataSource,  UITableViewDelegate, AddrDetailCellDelegate, BEMCheckBoxDelegate>

-(instancetype)initWithAddresses:(NSArray*)addresses;

@end
