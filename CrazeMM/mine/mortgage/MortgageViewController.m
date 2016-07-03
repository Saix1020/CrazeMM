//
//  MortgageViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageViewController.h"

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


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.segmentTitles = @[@"待入库", @"待放款", @"在抵押"];
    self.usingDefaultCell = YES;
    self.autoRefresh = YES;
    
    self.navigationItem.title = @"我的抵押";
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x) {
        return [RACSignal empty];
    }];

    
    self.bottomViewButtonTitle = @"批量删除";
    
    
    UIBarButtonItem* addMortgageButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"addr_add_icon" image] style:UIBarButtonItemStylePlain target:self action:@selector(addMortgage:)];
    UIBarButtonItem* moreButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreActions:)];
    self.navigationItem.rightBarButtonItems = @[moreButtonItem, addMortgageButtonItem];
}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    
}

-(void)addMortgage:(id)sender
{
    
}

-(void)moreActions:(id)sender
{
    
}

-(void)updateBottomView
{
    [super updateBottomView];
}

@end
