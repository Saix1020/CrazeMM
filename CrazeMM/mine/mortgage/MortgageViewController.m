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
    
    //two buttons are needed, "add" and "more"
    UIView *rightBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 31)];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(10, 5, 25, 25);
    [addButton setImage:[UIImage imageNamed:@"addr_add_icon"] forState:UIControlStateNormal];
    addButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x) {
        MortgageEditViewController* editVC = [[MortgageEditViewController alloc] init];
        editVC.delegate = self;
        [self.navigationController pushViewController:editVC animated:YES];
        return [RACSignal empty];
    }];
    [rightBarView addSubview:addButton];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(50, 5, 25, 25);
    [moreButton setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
    moreButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x) {
        [self.moreActionSheet showInView:self.view];
        return [RACSignal empty];
    }];
    [rightBarView addSubview:moreButton];

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBarView];
    
    
    self.navigationItem.rightBarButtonItem = rightBtn;
}


#pragma -- mark MortgageEditViewControllerDelegate Delegate
-(void)editMortgageSuccess
{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    
    self.pageNumber = 0;
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
