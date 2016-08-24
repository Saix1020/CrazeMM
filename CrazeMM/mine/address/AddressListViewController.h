//
//  AddressListViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressListCell.h"

@protocol AddressListViewControllerDelegate <NSObject>

-(void)didSelectedAddress:(AddrDTO*)address;

@end


@interface AddressListViewController : UIViewController<UITableViewDataSource,  UITableViewDelegate, AddressListCellDelegate>
@property (nonatomic, weak) id<AddressListViewControllerDelegate> delegate;
-(instancetype)initWithAddresses:(NSArray*)addresses;

@end
