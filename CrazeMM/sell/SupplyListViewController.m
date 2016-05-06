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


@interface SupplyListViewController ()

@end

@implementation SupplyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"189 疯狂买卖王 供货";
    
//    HttpSupplyRequest* supplyRequest = [[HttpSupplyRequest alloc] init];
//    [supplyRequest request]
//    .then(^(id responseObject){
//        NSLog(@"%@", responseObject);
//    });
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductSummaryCell *cell = (ProductSummaryCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.cellType = @"供货";
    
    return cell;
}


@end
