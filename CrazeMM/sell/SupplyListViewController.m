//
//  SellViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyListViewController.h"
#import "HttpSupplyRequest.h"
#import "ProductSummaryCell.h"
#import "HttpSupplyNoLoginRequest.h"
#import "SupplyProductViewController.h"


@interface SupplyListViewController ()



@end

@implementation SupplyListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"189 疯狂买卖王 供货";
    //self.dataSource = [@[] mutableCopy];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(AnyPromise*)getProducts:(BOOL)needHud
{
    HttpSupplyRequest* request;
    if ([[UserCenter defaultCenter] isLogined]) {
        request = [[HttpSupplyRequest alloc] initWithPageNumber:self.pageNumber+1];
    }
    else{
        request = [[HttpSupplyNoLoginRequest alloc] initWithPageNumber:self.pageNumber+1];
    }
    if (needHud) {
        [self showProgressIndicatorWithTitle:@"正在努力加载..."];
    }
    return [request request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
        HttpSupplyResponse* response = (HttpSupplyResponse*)request.response;
        if(response.ok){
            self.pageNumber = response.pageNumber;
            self.totalPage = response.totalPage;
            [self.dataSource addObjectsFromArray:response.productDTOs];
            [self.tableView reloadData];
        }
//        if (needHud) {
//            [self dismissProgressIndicator];
//        }
    })
    .catch(^(NSError* error){
//        if (needHud) {
//            [self dismissProgressIndicator];
//        }
        if ([error needLogin]) {
            [self showAlertViewWithMessage:@"请先登录"];
        }
        else {
            [self showAlertViewWithMessage:error.localizedDescription];
        }
    })
    .finally(^(){
        if (needHud) {
            [self dismissProgressIndicator];
        }
    });
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductSummaryCell *cell = (ProductSummaryCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.cellType = @"供货";
    cell.productDto = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SupplyProductDTO* dto = self.dataSource[indexPath.row];
    SupplyProductViewController* vc = [[SupplyProductViewController alloc] initWithProductDTO:dto];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
