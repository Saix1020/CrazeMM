//
//  OrderListFilterViewController.h
//  CrazeMM
//
//  Created by saix on 16/8/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DateRangePickerCell.h"

@protocol OrderListFilterViewControllerDelegate <NSObject>

-(void)dismiss;
-(void)didSetSerachConditions:(NSDictionary*)conditions;
@end


@interface OrderListFilterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, OrderListFilterViewControllerDelegate, DateRangePickerCellDelegate>

@property (nonatomic, weak) id<OrderListFilterViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* filterType;

-(instancetype)initWithSearchConditions:(NSDictionary*)conditons;

@end