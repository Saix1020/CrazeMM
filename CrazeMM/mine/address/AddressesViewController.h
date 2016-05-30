//
//  AddressesViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddrDetailCell.h"

@protocol AddressesViewControllerDelegate <NSObject>

-(void)didSelectedAddress:(AddrDTO*)address;

@end


@interface AddressesViewController : UIViewController<UITableViewDataSource,  UITableViewDelegate, AddrDetailCellDelegate, BEMCheckBoxDelegate>
@property (nonatomic, weak) id<AddressesViewControllerDelegate> delegate;

-(instancetype)initWithAddresses:(NSArray*)addresses;


@end
