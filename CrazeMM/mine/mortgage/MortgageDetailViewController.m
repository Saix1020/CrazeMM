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


@end
