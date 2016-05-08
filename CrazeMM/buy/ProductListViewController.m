//
//  ProductListViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/2.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductListViewController.h"
#import "BuyItemCell.h"

@implementation ProductListViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"189 疯狂买卖王 求购";
    //self.navigationController
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];

//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerNib:[UINib nibWithNibName:@"BuyItemCell" bundle:nil] forCellReuseIdentifier:@"BuyItemCell"];
//    [self.view addSubview:self.tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BuyItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BuyItemCell"];
//    cell.productDescDTO = self.dataSource[indexPath.row];
//    if (!cell.timeSignal) {
//        cell.timeSignal = self.updateEventSignal;
//    }
    //    ProductListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListCell"];
    //    if (!cell) {
    //        cell = [[ProductListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductListCell"];
    //    }
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductListCell"];
        }
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //cell.imageView.image = [@"card" image];
    cell.textLabel.text = @"Test";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}


@end
