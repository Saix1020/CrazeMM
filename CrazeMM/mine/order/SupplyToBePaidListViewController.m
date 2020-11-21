//
//  SupplyToBePaidListViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyToBePaidListViewController.h"
#import "PayingViewController.h"
#import "ToBePaidViewController.h"

@implementation SupplyToBePaidListViewController

-(BOOL)hiddenCheckBox
{
    return YES;
}


-(BOOL)hiddenBottomView
{
    return YES;
}

-(NSArray*)segmentTitles
{
    return @[@"待支付", @"支付中"];
}

-(MMOrderListStyle)orderListStyle
{
    MMOrderListStyle orderListStyle = [super orderListStyle];
    orderListStyle.orderType = kOrderTypeSupply;
    
    return orderListStyle;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我卖的货";
}


-(void)tableViewCellSelected:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath
{
    OrderDetailViewController* vc;
    OrderDetailDTO* dto = (OrderDetailDTO*)[self dtoAtIndexPath:indexPath];
    switch (self.selectedSegmentIndex) {
        case 0:
            vc = [[ToBePaidViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        case 1:
            vc = [[PayingViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        default:
            break;
    }
    
    if (vc) {
        vc.delegate = self;
        [self setMarkedVC:self]; // 
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
