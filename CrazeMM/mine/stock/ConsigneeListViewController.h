//
//  ConsigneeListViewController.h
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsigneeDTO.h"
#import "ConsigneeCell.h"

@protocol ConsigneeListViewControllerDelegate <NSObject>

-(void)didSelectedConsignee:(ConsigneeDTO*)consigneeDto;

@end


@interface ConsigneeListViewController : UITableViewController<ConsigneeCellDelegate>


@property (nonatomic, weak) id delegate;

@end
