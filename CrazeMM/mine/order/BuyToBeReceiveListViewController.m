//
//  BuyToBeReceiveListViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyToBeReceiveListViewController.h"

@implementation BuyToBeReceiveListViewController

-(NSInteger)initSegmentIndex
{
    return 1; // 待签收
}

-(NSArray*)segmentTitles
{
    return @[@"待发货", @"待签收", @"待结款"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我买的货";
    self.bottomViewButtonTitle = @"签收";
    
}

-(MMOrderListStyle)orderListStyle
{
    MMOrderListStyle style = {
        .orderType = kOrderTypeBuy,
        .orderSubType = kOrderSubTypePay,
        .orderState = TOBERECEIVED
    };
    
    switch (self.selectedSegmentIndex) {
        case 0:
            style.orderState = TOBESENT; //
            break;
        case 1:
            style.orderState = TOBERECEIVED;
            break;
        case 2:
            style.orderState = TOBESETTLED;
            break;
            
        default:
            break;
    }
    
    return style;
}

-(BOOL)hiddenCheckBox
{
    switch (self.selectedSegmentIndex) {
        case 1: // "待签收"
            return  NO;
        default:
            return  YES;
    }
    
}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    // self.selectedData
    if (button == self.bottomView.confirmButton) {
        switch (self.selectedSegmentIndex) {
            case 1:
                [self receiveOrder];
                break;
            default:
                break;
        }
    }
}

-(void)receiveOrder
{
    NSLog(@"我买的货->待签收->签收");
    NSArray* operatorDtos = self.selectedData;

    if (operatorDtos.count == 0) {
        [self showAlertViewWithMessage:@"请选择需要签收的订单"];
        return;
    }
    
    
    [self invokeHttpRequest:[[HttpOrderReceiveRequest alloc] initWithOids:self.operatorDtoIds]
            andConfirmTitle:[NSString stringWithFormat:@"确定要签收选中的%ld条订单吗?", operatorDtos.count]
            andSuccessTitle:@"操作成功"];
}


- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    [super segment:segment didSelectAtIndex:index];
    
    switch (index) {
        case 0:
            self.hiddenBottomView = YES;
            break;
        case 1:
            self.bottomView.totalPriceLabel.hidden = YES;
            self.hiddenBottomView = NO;
            [self.bottomView.confirmButton setTitle:@"签收" forState:UIControlStateNormal];
            break;
        case 2:
            self.bottomView.totalPriceLabel.hidden = YES;
            self.hiddenBottomView = YES;
            break;
            
        default:
            break;
    }
}

-(void)tableViewCellSelected:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath
{
    OrderDetailViewController* vc;
    OrderDetailDTO* dto = (OrderDetailDTO*)[self dtoAtIndexPath:indexPath];
    switch (self.selectedSegmentIndex) {
    }
    
    if (vc) {
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
