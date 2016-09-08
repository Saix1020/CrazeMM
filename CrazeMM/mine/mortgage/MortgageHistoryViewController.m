//
//  MortgageHistoryViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/9/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageHistoryViewController.h"
#import "MortgageDetailViewController.h"

@interface MortgageHistoryViewController ()

@end

@implementation MortgageHistoryViewController


-(HttpListQueryRequest*)makeListQueryRequest
{
    NSInteger status = 500;
    
   return [[HttpMortgageRequest alloc] initWithPageNum:self.pageNumber+1 andStatus:status];
}

-(BOOL)hiddenCheckBox
{
    return YES;
}

-(BOOL)hiddenSegment
{
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.usingDefaultCell = YES;
    self.autoRefresh = YES;
    self.hiddenBottomView = YES;
    
    self.navigationItem.title = @"我的抵押历史";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark tableview delegate
-(void)tableViewCellSelected:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    
    MortgageDTO* dto = self.dataSource[indexPath.row/2];
    
    MortgageDetailViewController* vc = [[MortgageDetailViewController alloc] initWithMortgageDTO:dto];;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
