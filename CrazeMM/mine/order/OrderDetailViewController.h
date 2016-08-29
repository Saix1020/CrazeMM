//
//  OrderDetailViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"
#import "OrderDefine.h"
#import "OrderDetailHeadCell.h"
#import "OrderDetailAddrCell.h"
#import "OrderDetailStatusCell.h"
#import "OrderLogsCell.h"
#import "OrderListNoCheckBoxCell.h"

@protocol OrderDetailViewControllerDelegate <NSObject>

-(void)removeOrder:(OrderDetailDTO*)orderDto;
-(void)cancelOrder:(OrderDetailDTO*)orderDto;
-(void)operatorDoneForOrder:(NSArray*)orderDtos;

@end


@interface OrderDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic) MMOrderListStyle style;
@property (nonatomic, strong) OrderDetailDTO* orderDto;
@property (nonatomic, strong) OrderStatusDTO* orderStatusDto;


@property (nonatomic, strong) OrderDetailHeadCell* headCell;
@property (nonatomic, strong) OrderDetailAddrCell* addrCell;
@property (nonatomic, strong) OrderListNoCheckBoxCell* contentCell;
@property (nonatomic, strong) OrderDetailStatusCell* statusCell;
@property (nonatomic, strong) OrderLogsCell* logsCell;

@property (nonatomic, readonly) NSString* titleString;
@property (nonatomic, readonly) NSString* titleDetailString;
@property (nonatomic, readonly) NSString* bottomButtonString;
@property (nonatomic, readonly) NSInteger leftSeconds;
@property (nonatomic, readonly) NSInteger elapseSeconds;

@property (nonatomic, weak) id<OrderDetailViewControllerDelegate> delegate;

-(instancetype)initWithOrderStyle:(MMOrderListStyle)style andOrder:(OrderDetailDTO*)orderDto;
+(OrderDetailViewController*)initWithOrderStyle:(MMOrderListStyle)style andOrder:(OrderDetailDTO*)orderDto;
-(void)handleClickEvent:(UIButton*)button;
@end
