//
//  MortgageViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageViewController.h"
#import "MortgageHistoryViewController.h"
#import "MortgageRefundViewController.h"
#import "MortgageDetailViewController.h"

@interface MortgageViewController()

@property (nonatomic, strong) UIActionSheet* moreActionSheet;

@end

@implementation MortgageViewController

-(HttpListQueryRequest*)makeListQueryRequest
{
    NSInteger status = 100;
    
    switch (self.selectedSegmentIndex) {
        case 0:
            status = 100;
            self.bottomViewButtonTitle = @"批量删除";
            break;
        case 1:
            status = 200;
            self.bottomViewButtonTitle = @"批量撤销";
            break;
        case 2:
            status = 300;
            self.bottomViewButtonTitle = @"合并付款";
            break;

        default:
            break;
    }
    return [[HttpMortgageRequest alloc] initWithPageNum:self.pageNumber+1 andStatus:status];
}

-(UIActionSheet*)moreActionSheet
{
    if (!_moreActionSheet) {
        _moreActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"抵押历史", nil];
        _moreActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        
    }
    
    return _moreActionSheet;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.segmentTitles = @[@"待入库", @"待放款", @"在抵押"];
    self.usingDefaultCell = YES;
    self.autoRefresh = YES;
    
    self.navigationItem.title = @"我的抵押";
    
    
    UIBarButtonItem* addMortgageButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"addr_add_icon" image] style:UIBarButtonItemStylePlain target:self action:@selector(addMortgage:)];
    UIBarButtonItem* moreButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"icon_more" image] style:UIBarButtonItemStylePlain target:self action:@selector(moreActions:)];
    self.navigationItem.rightBarButtonItems = @[moreButtonItem, addMortgageButtonItem];
}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    
    NSMutableArray* ids = [[NSMutableArray alloc]init];
    NSMutableArray* stockIds = [[NSMutableArray alloc]init];
    NSArray* onArray = self.selectedData;
    NSInteger state = ((MortgageDTO*)(onArray.firstObject)).state;
    if ( 0 == onArray.count)
    {
        [self showAlertViewWithMessage:@"请选择"]; //需要删除的抵押申请
        return;
    }
    
    for (MortgageDTO* mortgageDto in onArray) {
        [ids addObject: [NSString stringWithFormat:@"%ld", mortgageDto.id]];
        [stockIds addObject:[NSString stringWithFormat:@"%ld", mortgageDto.stockId]];
    }
    
    @weakify(self);
    switch (state) {
        case 100:
        {
            [self showAlertViewWithMessage:[NSString stringWithFormat:@"您确认删除该抵押申请%@？",[ids componentsJoinedByString:@","]]
                            withOKCallback:^(id x){
                                @strongify(self);
                                
                                HttpMortgageDeleteRequest* request = [[HttpMortgageDeleteRequest alloc] initWithIds:ids StockIds:stockIds];
                                [request request]
                                .then(^(id responseObj){
                                    if (!request.response.ok) {
                                        [self showAlertViewWithMessage:request.response.errorMsg];
                                    }
                                    else {
                                        [self showAlertViewWithMessage:@"删除成功"];
                                        [self resetDataSource];
                                    }
                                })
                                .catch(^(NSError* error){
                                    [self showAlertViewWithMessage:error.localizedDescription];
                                });
                                
                            }
                         andCancelCallback:^(id x){
                             
                         }];
            break;
        }
        case 200:
        {
            
            [self showAlertViewWithMessage:[NSString stringWithFormat:@"撤销抵押%@？撤销抵押后货品库存将会变成正常库存", [ids componentsJoinedByString:@","] ]
                            withOKCallback:^(id x){
                                @strongify(self);
                                HttpMortgageCancelRequest* request = [[HttpMortgageCancelRequest alloc] initWithIds:ids];
                                [request request]
                                .then(^(id responseObj){
                                    if (!request.response.ok) {
                                        [self showAlertViewWithMessage:request.response.errorMsg];
                                    }
                                    else {
                                        [self showAlertViewWithMessage:@"撤销成功"];
                                        [self resetDataSource];
                                    }
                                    
                                })
                                .catch(^(NSError* error){
                                    [self showAlertViewWithMessage:error.localizedDescription];
                                });
                                
                                
                            }
                         andCancelCallback:^(id x){
                             
                         }];

            break;
        }
        case 300:
        {
            MortgageRefundViewController* refundVC = [[MortgageRefundViewController alloc] initWithDtos:onArray];
            [self.navigationController pushViewController:refundVC animated:YES];
            break;
        }
            
        default:
            break;
    }
    

}

-(void)addMortgage:(id)sender
{
    MortgageEditViewController* editVC = [[MortgageEditViewController alloc] init];
    editVC.delegate = self;
    [self.navigationController pushViewController:editVC animated:YES];
}

-(void)moreActions:(id)sender
{
    [self.moreActionSheet showInView:self.view];
}

-(void)updateBottomView
{
    [super updateBottomView];
}

#pragma - mark tableview delegate
-(void)tableViewCellSelected:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    
    MortgageDTO* dto = self.dataSource[indexPath.row/2];
    
    MortgageDetailViewController* vc = [[MortgageDetailViewController alloc] initWithMid:dto.id];;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma -- mark MortgageEditViewControllerDelegate Delegate
-(void)editMortgageSuccess
{
    //[self.dataSource removeAllObjects];
    //[self.tableView reloadData];
    
    //self.pageNumber = 0;
    [self requestDataSource];
    
}

#pragma mark -- action sheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            MortgageHistoryViewController* mortgageHistoryVC = [[MortgageHistoryViewController alloc] init];
            [self.navigationController pushViewController:mortgageHistoryVC animated:YES];
            break;
        }
            
        default:
            break;
            
    }
}

#pragma mark - button Belegate
-(void)rightButtonClicked:(CommonListCell *)cell
{
    NSMutableArray* ids = [[NSMutableArray alloc]init];
    NSMutableArray* stockIds = [[NSMutableArray alloc]init];
    
    [ids addObject: [NSString stringWithFormat:@"%ld", ((MortgageDTO*)cell.dto).id]];
    [stockIds addObject:[NSString stringWithFormat:@"%ld", ((MortgageDTO*)cell.dto).stockId]];

    @weakify(self);
    switch (((MortgageDTO*)cell.dto).state) {
        case 100:
        {
           [self showAlertViewWithMessage:[NSString stringWithFormat:@"确定删除抵押吗？"]
                            withOKCallback:^(id x){
                                @strongify(self);
                                HttpMortgageDeleteRequest* request = [[HttpMortgageDeleteRequest alloc] initWithIds:ids StockIds:stockIds];
                                [request request]
                                .then(^(id responseObj){
                                    if (!request.response.ok) {
                                        [self showAlertViewWithMessage:request.response.errorMsg];
                                    }
                                    else {
                                        [self showAlertViewWithMessage:@"删除成功"];
                                        [self resetDataSource];
                                    }
                                    
                                })
                                .catch(^(NSError* error){
                                    [self showAlertViewWithMessage:error.localizedDescription];
                                });
                                
                                
                            }
                         andCancelCallback:^(id x){
                             
                         }];
            break;
        }
            
        case 200:
        {
            [self showAlertViewWithMessage:[NSString stringWithFormat:@"撤销抵押%ld？撤销抵押后货品库存将会变成正常库存", ((MortgageDTO*)cell.dto).id ]
                            withOKCallback:^(id x){
                                @strongify(self);
                                HttpMortgageCancelRequest* request = [[HttpMortgageCancelRequest alloc] initWithIds:ids];
                                [request request]
                                .then(^(id responseObj){
                                    if (!request.response.ok) {
                                        [self showAlertViewWithMessage:request.response.errorMsg];
                                    }
                                    else {
                                        [self showAlertViewWithMessage:@"撤销成功"];
                                        [self resetDataSource];
                                    }
                                    
                                })
                                .catch(^(NSError* error){
                                    [self showAlertViewWithMessage:error.localizedDescription];
                                });
                                
                                
                            }
                         andCancelCallback:^(id x){
                             
                         }];
            break;
        }

            break;
            
        case 300:
        {
            NSArray* selectedDtos = [NSArray arrayWithObject:((MortgageDTO*)cell.dto)];
            MortgageRefundViewController* refundVC = [[MortgageRefundViewController alloc] initWithDtos:selectedDtos];
            [self.navigationController pushViewController:refundVC animated:YES];
            
            break;
        }
            
        default:
            break;
    }
    

}



@end
