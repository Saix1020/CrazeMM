//
//  BuyAllListViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyAllListViewController.h"
#import "AllOrderListFilterViewController.h"

// All detail vc
#import "ToBePaidViewController.h"
#import "ToBeSentViewController.h"
#import "ToBeSettledViewController.h"
#import "ToBeReceivedViewController.h"
#import "ToBePaidViewController.h"
#import "PayingViewController.h"
#import "PayTimeoutViewController.h"
#import "CompleteViewController.h"
#import "ODCanceledViewController.h"
#import "ODArbitratingViewController.h"
#import "ODToBeConfirmedViewController.h"
#import "ODDeletedViewController.h"
#import "ODReturningViewController.h"
#import "ODPayBackViewController.h"
#import "ODClosedViewController.h"


@implementation BuyAllListViewController

+(NSDictionary*)orderDetailVCClass
{
    NSDictionary* dict = @{
                           
                           @(TOBEPAID) : [ToBePaidViewController class], //
                           @(PAYING) : [PayingViewController class],//
                           @(CANCELED) : [ODCanceledViewController class], //
                           @(TOBESENT) : [ToBeSentViewController class], //
                           @(TOBERECEIVED) : [ToBeReceivedViewController class], //
                           @(TOBESETTLED) : [ToBeSettledViewController class],  //
                           @(TOBECONFIRMED) : [ODToBeConfirmedViewController class],
                           @(COMPLETED) : [CompleteViewController class],//
                           @(ORDERCLOSE) : [ODClosedViewController class], //
                           @(PAYTIMEOUT) : [PayTimeoutViewController class], //
                           @(RETURNING) : [ODReturningViewController class], //
                           @(ARBITRATING) : [ODArbitratingViewController class], //
                           @(PAYBACK) : [ODPayBackViewController class]

                           
                           
                           };
    return dict;
}

-(BOOL)hiddenSegment
{
    return YES;
}

-(BOOL)hiddenBottomView
{
    return YES;
}

-(BOOL)hiddenCheckBox
{
    return YES;
}

-(MMOrderListStyle)orderListStyle
{
    MMOrderListStyle style = {
        .orderType = kOrderTypeBuy,
        .orderSubType = kOrderSubTypeAll,
        .orderState = TOBEPAID
    };
    
    return style;
}

-(OrderListFilterViewController *)filterVC
{
    if (!_filterVC) {
        _filterVC = [[AllOrderListFilterViewController alloc] init];
        _filterVC.delegate = self;
    }
    
    return _filterVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的所有买货";
}

-(HttpListQueryRequest*)makeListQueryRequest
{
    return [[HttpAllBuyOrderRequest alloc]  initWithPage:self.pageNumber+1 andConditions:self.searchConditions];
}

-(void)tableViewCellSelected:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath
{
    OrderDetailViewController* vc;
    OrderDetailDTO* dto = (OrderDetailDTO*)[self dtoAtIndexPath:indexPath];
    
    Class orderDetailClass = [BuyAllListViewController orderDetailVCClass][@(dto.state)];
    if (orderDetailClass && [(NSObject*)orderDetailClass respondsToSelector:@selector(initWithOrderStyle:andOrder:)]) {
        vc = [[orderDetailClass alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
    }
    
    
//    switch (dto.state) {
//        case TOBEPAID:
//            vc = [[ToBePaidViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
//            break;
//        case PAYTIMEOUT:
//            vc = [[PayTimeoutViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
//
//            break;
//        case PAYING:
//            vc = [[PayingViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
//            break;
//        case TOBESENT:
//            vc = [[ToBeSentViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
//            break;
//        case TOBERECEIVED:
//            vc = [[ToBeReceivedViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
//
//            break;
//        case TOBESETTLED:
//            vc = [[ToBeSettledViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
//
//            break;
//        case COMPLETED:
//            vc = [[CompleteViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
//            break;
//        default:
//            break;
//    }
    
    if (vc) {
        vc.delegate = self;
        [self setMarkedVC:self];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
