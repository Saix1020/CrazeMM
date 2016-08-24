//
//  PayInfoViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/8/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayInfoViewController.h"
#import "CommonListCell+PayRecord.h"

@interface PayInfoViewController ()

@end

@implementation PayInfoViewController

- (HttpPayRecordRequest*)makeListQueryRequest
{
    NSInteger status = 100;
    
    switch (self.selectedSegmentIndex) {
        case 0:
            status = 100;
            break;
        case 1:
            status = 200;
            break;
        case 2:
            status = 300;
            break;
            
        default:
            break;
    }
    return [[HttpPayRecordRequest alloc] initWithPageNum:self.pageNumber+1 andStatus:status];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentTitles = @[@"支付中", @"成功", @"失败"];
    self.usingDefaultCell = YES;
    self.autoRefresh = YES;
    self.navigationItem.title = @"我的支付记录";
    self.bottomView.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - button Belegate

-(void)leftButtonClicked:(CommonListCell *)cell
{
    @weakify(self);
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"您确认要刷新订单P%ld吗?", ((PayRecordDTO*)cell.dto).payNo]
                    withOKCallback:^(id x){
                        @strongify(self);
                        HttpPayRefreshRequest* request = [[HttpPayRefreshRequest alloc] initWithPayNo:((PayRecordDTO*)cell.dto).payNo];
                        [request request].then(^(id responseObj){
                            if (!request.response.ok) {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                            else {
                                [self showAlertViewWithMessage:@"订单刷新成功！"];
                                //是否要刷新页面？
                            }

                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                    }
                 andCancelCallback:^(id x){
                     
                 }];

}

-(void)rightButtonClicked:(CommonListCell *)cell
{
    @weakify(self);
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"您确认要设置订单P%ld失败吗?", ((PayRecordDTO*)cell.dto).payNo]
                    withOKCallback:^(id x){
                        @strongify(self);
                        HttpPayCancelRequest* request = [[HttpPayCancelRequest alloc] initWithPayNo:((PayRecordDTO*)cell.dto).payNo];
                        [request request].then(^(id responseObj){
                            if (!request.response.ok) {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                            else {
                                [self showAlertViewWithMessage:@"订单取消成功！"];
                                //是否要刷新页面？
                            }
                            
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });

                        
                    }
                 andCancelCallback:^(id x){
                     
                 }];
}


-(void)topButtonClicked:(CommonListCell *)cell
{
    @weakify(self);
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"您要重新支付订单P%ld吗?", ((PayRecordDTO*)cell.dto).payNo]
                    withOKCallback:^(id x){
                        @strongify(self);
                        HttpPayDataRequest* request = [[HttpPayDataRequest alloc] initWithPayNo:((PayRecordDTO*)cell.dto).payNo];
                        [request request].then(^(id responseObj){
                            if (!request.response.ok) {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                            else {
                                [self showAlertViewWithMessage:@"订单重新支付成功！"];
                                //是否要跳转到支付页面？
                            }
                            
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                        
                        
                    }
                 andCancelCallback:^(id x){
                     
                 }];
}



@end
