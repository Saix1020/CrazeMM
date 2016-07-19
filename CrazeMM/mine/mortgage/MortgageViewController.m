//
//  MortgageViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageViewController.h"

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
    self.bottomViewButtonTitle = @"批量删除";
    
    
    UIBarButtonItem* addMortgageButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"addr_add_icon" image] style:UIBarButtonItemStylePlain target:self action:@selector(addMortgage:)];
    UIBarButtonItem* moreButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"icon_more" image] style:UIBarButtonItemStylePlain target:self action:@selector(moreActions:)];
    self.navigationItem.rightBarButtonItems = @[moreButtonItem, addMortgageButtonItem];}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    
    NSMutableArray* ids = [[NSMutableArray alloc]init];
    NSMutableArray* stockIds = [[NSMutableArray alloc]init];
    NSArray* onArray = self.selectedData;
    if ( 0 == onArray.count)
    {
        [self showAlertViewWithMessage:@"请选择需要删除的抵押申请"];
        return;
    }
    
    for (MortgageDTO* mortgageDto in onArray) {
        [ids addObject: [NSString stringWithFormat:@"%ld", mortgageDto.id]];
        [stockIds addObject:[NSString stringWithFormat:@"%ld", mortgageDto.stockId]];
    }
    
    @weakify(self);
    
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"您确认删除该抵押申请%@",[ids componentsJoinedByString:@","]]
                    withOKCallback:^(id x){
                        @strongify(self);
                        
                        HttpMortgageDeleteRequest* request = [[HttpMortgageDeleteRequest alloc] initWithIds:ids StockIds:stockIds];
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
            break;
            
        default:
            break;
            
    }
}


@end
