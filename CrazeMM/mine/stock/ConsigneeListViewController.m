//
//  ConsigneeListViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ConsigneeListViewController.h"
#import "HttpConsignee.h"
#import "ConsigneeAddViewController.h"

@interface ConsigneeListViewController ()

@property (nonatomic, copy) NSArray* dataSource;

@end

@implementation ConsigneeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择自提人";
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ConsigneeCell" bundle:nil] forCellReuseIdentifier:@"ConsigneeCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addr_add_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x) {
        
        ConsigneeAddViewController* addrEditVC = [[ConsigneeAddViewController alloc] init];
        [self.navigationController pushViewController:addrEditVC animated:YES];
        
        return [RACSignal empty];
    }];

    
    [self getConsignees];
}

-(void)getConsignees
{
    HttpConsigneeRequest* request = [[HttpConsigneeRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        HttpConsigneeResponse* response = (HttpConsigneeResponse*)request.response;
        if (response.ok) {
            self.dataSource = response.consigneeDtos;
//            self.selectedConsigneeDto = self.consignees.firstObject;
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row%2==1) {
//        return <#expression#>
//    }
    
    return [ConsigneeCell cellHeight];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsigneeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConsigneeCell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.consigneeDto = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark ConsigneeCell Delegate
-(void)editButtonClicked:(ConsigneeCell*)cell
{
    ConsigneeAddViewController* consigneeAddVC = [[ConsigneeAddViewController alloc] initWithConsigneeDTO:cell.consigneeDto];
    [self.navigationController pushViewController:consigneeAddVC animated:YES];
}

@end
