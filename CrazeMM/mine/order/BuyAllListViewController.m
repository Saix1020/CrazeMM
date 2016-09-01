//
//  BuyAllListViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyAllListViewController.h"
#import "ToBePaidViewController.h"
#import "ToBeSentViewController.h"
#import "ToBeSettledViewController.h"
#import "ToBeReceivedViewController.h"
#import "ToBePaidViewController.h"
#import "PayingViewController.h"
#import "PayTimeoutViewController.h"
#import "CompleteViewController.h"
#import "AllOrderListFilterViewController.h"

@implementation BuyAllListViewController

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
    
    switch (dto.state) {
        case TOBEPAID:
            vc = [[ToBePaidViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        case PAYTIMEOUT:
            vc = [[PayTimeoutViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];

            break;
        case PAYING:
            vc = [[PayingViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        case TOBESENT:
            vc = [[ToBeSentViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        case TOBERECEIVED:
            vc = [[ToBeReceivedViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];

            break;
        case TOBESETTLED:
            vc = [[ToBeSettledViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];

            break;
        case COMPLETED:
            vc = [[CompleteViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        default:
            break;
    }
    
    if (vc) {
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
