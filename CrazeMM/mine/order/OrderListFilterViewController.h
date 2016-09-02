//
//  OrderListFilterViewController.h
//  CrazeMM
//
//  Created by saix on 16/8/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DateRangePickerCell.h"
#import "TPKeyboardAvoidingTableView.h"

@protocol OrderListFilterViewControllerDelegate <NSObject>

-(void)dismiss;
-(void)didSetSerachConditions:(NSDictionary*)conditions;
@end


@interface OrderListFilterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, DateRangePickerCellDelegate>

@property (nonatomic, weak) id<OrderListFilterViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* filterType;
@property (nonatomic, readonly) NSArray* cellArray;
@property (nonatomic, readonly) NSDictionary* conditions;
@property (nonatomic, readonly) TPKeyboardAvoidingTableView* tableView;

-(instancetype)initWithSearchConditions:(NSDictionary*)conditons;
-(void)setSearchCond:(UIButton*)button;
-(void)resetSearchCond;
@end
