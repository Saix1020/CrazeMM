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
@property (nonatomic, strong) OrderLogsCell* repayCell;
@property (nonatomic, readonly) NSArray* repayDtos;

@property (nonatomic, strong) MortgageDTO* mortgageDto;
@property (nonatomic) NSInteger supplyId;

@end

@implementation MortgageDetailViewController

-(OrderLogsCell*)repayCell
{
    if (!_repayCell) {
        _repayCell = (OrderLogsCell*)[UINib viewFromNib:@"OrderLogsCell"];
        _repayCell.backgroundColor = [UIColor clearColor];
    }
    
    return _repayCell;
}

-(NSArray*)cellArray
{
    if (self.loading) {
        return @[];
    }
    else {
        if (self.mortgageDto.state!=500) { //历史
            return @[self.productDetail, self.logsCell];
            
        }
        else{
            return @[self.productDetail, self.repayCell, self.logsCell];
            
        }
    }
    
}

-(NSArray*)bottomButtonsTitle
{
    return @[];
}

-(void)setMoreDtosWithResponse:(BaseHttpResponse *)response
{
    HttpMortgageDetailResponse* detailResponse = (HttpMortgageDetailResponse*)response;
    
    self.repayCell.logs = detailResponse.detailDto.repays;
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
        if([detailResponse.detailDto.listDto isKindOfClass:[MortgageDTO class]]){
            ((MortgageDTO*)detailResponse.detailDto.listDto).supplyId = self.supplyId; //reset supplyId
        }
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

-(instancetype)initWithMortgageDTO:(MortgageDTO*)mortgageDto
{
    self = [super init];
    if (self) {
        self.mid = mortgageDto.id;
        self.mortgageDto = mortgageDto;
        self.supplyId = mortgageDto.supplyId; //save the supplyId
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
    if (indexPath.row == 2 || indexPath.row == 4) {
        return 32;
    }
    
    if (indexPath.row==1) { //list detail cell
        if (self.mortgageDto.state == 300) {
            return height + 24.f;
        }
    }
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 2) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(14.f, 14.f, 320, 14.f)];
        label.font = [UIFont smallFont];
        label.textColor = [UIColor grayColor];
        label.text = @"抵押还款明细";
        [cell addSubview:label];
        cell.clipsToBounds = NO;
    }
    else if(indexPath.row == 4){
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(14.f, 14.f, 320, 14.f)];
        label.font = [UIFont smallFont];
        label.textColor = [UIColor grayColor];
        label.text = @"抵押状态日志";

        cell.textLabel.font = [UIFont smallFont];
        cell.textLabel.textColor = [UIColor grayColor];
        [cell addSubview:label];
        cell.clipsToBounds = NO;


    }
    
    return cell;
    
}


@end
