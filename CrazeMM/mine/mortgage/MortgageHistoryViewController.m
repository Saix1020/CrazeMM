//
//  MortgageHistoryViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/9/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageHistoryViewController.h"

@interface MortgageHistoryViewController ()

@end

@implementation MortgageHistoryViewController


-(HttpListQueryRequest*)makeListQueryRequest
{
    NSInteger status = 500;
    
   return [[HttpMortgageRequest alloc] initWithPageNum:self.pageNumber+1 andStatus:status];
}


- (void)viewDidLoad {
    
    self.hiddenSegment =YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
