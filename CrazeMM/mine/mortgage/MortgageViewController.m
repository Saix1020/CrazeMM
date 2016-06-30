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
    
}


@end
