//
//  MortgageDetailViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/8.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageDetailViewController.h"
#import "HttpMortgage.h"

@interface MortgageDetailViewController ()

@property (nonatomic) NSInteger mid;

@end

@implementation MortgageDetailViewController

-(NSArray*)bottomButtonsTitle
{
    return @[];
}

-(BaseHttpRequest*)detailHttpRequest
{
    if(!_detailHttpRequest){
        _detailHttpRequest = [[HttpMortgageDetailRequest alloc] initWithMortgageId:self.mid];
    }
    return _detailHttpRequest;
}

-(id<BaseDetailDTO>)getDetailDtoFromResponse:(BaseHttpResponse*)response
{
    if ([response isKindOfClass:[HttpMortgageDetailResponse class]]) {
        HttpMortgageDetailResponse* detailResponse = (HttpMortgageDetailResponse*)response;
        return detailResponse.detailDto;
    }
    return nil;
}


-(instancetype)initWithMid:(NSInteger)mid
{
    self = [super init];
    if (self) {
        self.mid = mid;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"抵押%ld详情", self.mid];
}


#pragma - mark table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.row == 4) {
        return height + 24.f;
    }
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == self.logsCell) {
        UITableViewCell* wrappedCell = [[UITableViewCell alloc] init];
        UILabel* label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"抵押状态日志";
        label.font = [UIFont smallFont];
        label.textColor = [UIColor grayColor];
        [label sizeToFit];
        label.x = 20.f;
//        label.width = self.tableView.width;
        //label.
        cell.y = label.bottom + 4.f;
        cell.x = 8.f;
        
        [wrappedCell addSubview:label];
        [wrappedCell addSubview:cell];
        wrappedCell.backgroundColor = [UIColor clearColor];
        return wrappedCell;

    }
    
    return cell;
    
}


@end
