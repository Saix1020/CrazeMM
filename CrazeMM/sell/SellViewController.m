//
//  SellViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SellViewController.h"
#import "SellItemCell.h"
#import "HttpSupplyRequest.h"

@interface SellViewController ()

@end

@implementation SellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"189 疯狂买卖王 供货";
    
    HttpSupplyRequest* supplyRequest = [[HttpSupplyRequest alloc] init];
    [supplyRequest request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
    });
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SellItemCell *cell = (SellItemCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.arrawString = @"供货";
    
    return cell;
}


@end
