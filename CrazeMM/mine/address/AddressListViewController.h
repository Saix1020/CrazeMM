//
//  AddressListViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressListCell.h"

@interface AddressListViewController : UIViewController<UITableViewDataSource,  UITableViewDelegate, AddressListCellDelegate>

-(instancetype)initWithAddresses:(NSArray*)addresses;

@end
