//
//  WithdrawListViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WithdrawListViewController.h"
#import "HttpWithDraw.h"
#import "WithDrawLogCell.h"
@interface WithdrawListViewController ()

@end

@implementation WithdrawListViewController

- (void)viewDidLoad {
    [self.tableView registerNib:[UINib nibWithNibName:@"WithDrawLogCell" bundle:nil]  forCellReuseIdentifier:@"WithDrawLogCell"];

    [super viewDidLoad];
    self.navigationItem.title = @"我的提现";

    // Do any additional setup after loading the view.
}

-(CGFloat)cellHeight
{
    return 70.f;
}

-(AnyPromise*)query
{
    HttpWithDrawLogRequest* request = [[HttpWithDrawLogRequest alloc] initWithPageNum:self.pageNumber+1];
    return [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            HttpWithDrawLogResponse* response = (HttpWithDrawLogResponse*)request.response;
            self.pageNumber = response.pageNumber>=response.totalPage?response.totalPage:response.pageNumber;
            self.totalPage = response.totalPage;
            if (response.dtos.count>0) {
                [self.dataSource addObjectsFromArray:response.dtos];
                [self.tableView reloadData];
            }
        }
    })
    .finally(^(){
        self.requesting = NO;
    });
}

-(UITableViewCell*)listCellWithTabelview:(UITableView*)tableView andIndexPath:(NSIndexPath *)indexPath
{
    WithDrawLogCell* cell = [tableView dequeueReusableCellWithIdentifier:@"WithDrawLogCell"];
    cell.withDrawLogDto = self.dataSource[indexPath.row/2];
    return cell;
}

@end
