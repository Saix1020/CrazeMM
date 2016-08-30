//
//  BuyToBePaidListViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyToBePaidListViewController.h"
#import "HttpOrder.h"
#import "PayViewController.h"
#import "HttpOrderRemove.h"

@interface BuyToBePaidListViewController ()

@end

@implementation BuyToBePaidListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segmentTitles = @[@"待支付", @"支付中", @"支付超时"];
    self.navigationItem.title = @"我买的货";
    self.bottomViewButtonTitle = @"付款";
}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    // self.selectedData
    if (button == self.bottomView.confirmButton) {
        switch (self.selectedSegmentIndex) {
            case 0:
                [self payOrders];
                break;
            case 2:
                [self deleteOrders];
                break;
            
            default:
                break;
        }
    }
}

-(void)payOrders
{
    NSLog(@"我买的货->待付款->付款");
    NSArray* operatorDtos = self.selectedData;
    if (operatorDtos.count == 0) {
        [self showAlertViewWithMessage:@"请选择待付款的商品"];
        return;
    }
    
    if ([self isMixed:operatorDtos]) {
        [self showAlertViewWithMessage:@"不支持将卖家发货的订单与库存订单合并支付"];
        return;
    }
    
    PayViewController* payVC = [[PayViewController alloc] initWithOrderDetailDTOs:operatorDtos];
    [self.navigationController pushViewController:payVC animated:YES];
}

-(void)deleteOrders
{
    NSLog(@"我买的货->待付款->超时");
    NSArray* operatorDtos = self.selectedData;

    if (operatorDtos.count == 0) {
        [self showAlertViewWithMessage:@"请选择需要删除的订单"];
        return;
    }
    
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"确定要删除选中的%ld条订单吗?", self.operatorDtoIds.count]
                    withOKCallback:^(id x){
                        HttpOrderRemoveRequest* request = [[HttpOrderRemoveRequest alloc] initWithOrderIds:self.operatorDtoIds];
                        [request request]
                        .then(^(id responseObj){
                            NSLog(@"%@", responseObj);
                            if (request.response.ok) {
                                for (OrderDetailDTO* dto in operatorDtos){
                                    [self.dataSource removeObject:dto];
                                }
                                [self.tableView reloadData];
                            }
                            else {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                    }
                    andCancelCallback:nil];
}


-(BOOL)isMixed:(NSArray*)selectedDtos
{
    if (selectedDtos.count==0) {
        return NO;
    }
    
    OrderDetailDTO* firstDto = selectedDtos[0];
    BOOL hasStock = NO;
    if (firstDto.stock) {
        hasStock = YES;
    }
    
    for (OrderDetailDTO* dto in selectedDtos){
        if (dto.stock) {
            if (!hasStock) {
                return YES;
            }
        }
    }
    
    return NO;
}

-(MMOrderListStyle)orderListStyle
{
    MMOrderListStyle style = {
        .orderType = kOrderTypeBuy,
        .orderSubType = kOrderSubTypePay,
        .orderState = TOBEPAID
    };
    
    switch (self.selectedSegmentIndex) {
        case 0:
            style.orderState = TOBEPAID; //
            break;
        case 1:
            style.orderState = PAYING;
            break;
        case 2:
            style.orderState = PAYTIMEOUT;
            break;
            
        default:
            break;
    }
    
    return style;
}

-(BOOL)hiddenCheckBox
{
    switch (self.selectedSegmentIndex) {
        case 0:
            return  NO;
        case 1:
            return  YES;
        case 2:
            return  NO;
        default:
            return  YES;
    }

}

-(HttpListQueryRequest*)makeListQueryRequest
{
    return [[HttpOrderRequest alloc]  initWithOrderListType:self.orderListStyle andPage:self.pageNumber+1 andConditions:self.searchConditions];
}

#pragma -- mark custom segment delegate

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    [super segment:segment didSelectAtIndex:index];
    
    switch (index) {
        case 0:
            self.bottomView.totalPriceLabel.hidden = NO;
            self.hiddenBottomView = NO;
            [self.bottomView.confirmButton setTitle:@"付款" forState:UIControlStateNormal];

            break;
        case 1:
            self.bottomView.totalPriceLabel.hidden = YES;
            self.hiddenBottomView = YES;
            break;
        case 2:
            self.bottomView.totalPriceLabel.hidden = YES;
            self.hiddenBottomView = NO;
            [self.bottomView.confirmButton setTitle:@"删除" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

@end
