//
//  SellViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SellViewController.h"
#import "SellItemCell.h"

@interface SellViewController ()

@end

@implementation SellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"189 疯狂买卖王 供货";
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SellItemCell *cell = (SellItemCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.arrawView.text = @"供货";
    
    return cell;
}


@end
