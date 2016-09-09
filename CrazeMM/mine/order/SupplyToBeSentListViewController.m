//
//  SupplyToBeSentListViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyToBeSentListViewController.h"
#import "ToBeSentViewController.h"
#import "ToBeReceivedViewController.h"


@implementation SupplyToBeSentListViewController

-(NSArray*)segmentTitles
{
    return @[@"待发货", @"待签收"];
}

-(MMOrderListStyle)orderListStyle
{
    MMOrderListStyle style = {
        .orderType = kOrderTypeSupply,
        .orderSubType = kOrderSubTypeSend,
        .orderState = TOBESENT
    };
    
    switch (self.selectedSegmentIndex) {
        case 0:
            style.orderState = TOBESENT; 
            break;
        case 1:
            style.orderState = TOBERECEIVED;
            break;
            
        default:
            break;
    }
    
    return style;
}

-(BOOL)hiddenCheckBox
{
    switch (self.selectedSegmentIndex) {
        case 0: // "发货"
            return  NO;
        default:
            return  YES;
    }
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我卖的货";
    self.bottomViewButtonTitle = @"发货";
    
    self.bottomView.totalPriceLabel.hidden = YES;

}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    if (button == self.bottomView.confirmButton) {
        switch (self.selectedSegmentIndex) {
            case 0:
                [self sendOrder];
                break;
            default:
                break;
        }
    }
}

-(void)sendOrder
{
    NSLog(@"我卖的货->待发货->发货");
    NSArray* operatorDtos = self.selectedData;
    
    if (operatorDtos.count == 0) {
        [self showAlertViewWithMessage:@"请选择需要发货的订单"];
        return;
    }
    
    OrderSendViewController* sendVC = [[OrderSendViewController alloc] initWithOrderDetaildtos:operatorDtos];
    self.markedVC = self;
    [self.navigationController pushViewController:sendVC animated:YES];

}

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    [super segment:segment didSelectAtIndex:index];
    
    switch (index) {
        case 0:
            self.bottomView.hidden = NO;
            [self.bottomView.confirmButton setTitle:@"发货" forState:UIControlStateNormal];
            
            break;
        case 1:
            self.bottomView.hidden = YES;
            [self.bottomView.confirmButton setTitle:@"签收" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

#pragma  -- mark OrderSendVC delegate
-(void)sendSuccessWithOrderDetailDtos:(NSArray *)orderDetailDtos
{
    [self.dataSource removeObjectsInArray:orderDetailDtos];
}

#pragma - mark select table view cell
-(void)tableViewCellSelected:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath
{
    OrderDetailViewController* vc;
    OrderDetailDTO* dto = (OrderDetailDTO*)[self dtoAtIndexPath:indexPath];
    switch (self.selectedSegmentIndex) {
        case 0:
            vc = [[ToBeSentViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        case 1:
            vc = [[ToBeReceivedViewController alloc] initWithOrderStyle:self.orderListStyle andOrder:dto];
            break;
        default:
            break;
    }
    
    if (vc) {
        vc.delegate = self;
        [self setMarkedVC:self]; 
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
