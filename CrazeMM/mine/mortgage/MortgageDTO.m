//
//  MortgageDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageDTO.h"
@implementation MortgageDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        //@property (nonatomic) float interestRate;
//        @property (nonatomic) NSInteger quantity;
//        @property (nonatomic) NSInteger gid;
//        @property (nonatomic) NSInteger duration;
//        @property (nonatomic) float outPrice;
//        @property (nonatomic) float price;
//        @property (nonatomic) NSInteger stockId;
//        @property (nonatomic) NSInteger state;
//        
//        @property (nonatomic, copy) NSString* stateLabel;
//        @property (nonatomic, copy) NSString* depotName;
//        @property (nonatomic, copy) NSString* gimage;
//        @property (nonatomic, copy) NSString* updateTime;
//        @property (nonatomic, copy) NSString* goodName;
//        @property (nonatomic, copy) NSString* createTime;
//        @property (nonatomic, copy) NSString* checkTime;
        
        self.interestRate = [dict[@"interestRate"] floatValue];
        self.outPrice = [dict[@"outPrice"] floatValue];
        self.price = [dict[@"price"] floatValue];

        self.quantity = [dict[@"quantity"] integerValue];
        self.gid = [dict[@"gid"] integerValue];
        self.duration = [dict[@"duration"] integerValue];
        self.stockId = [dict[@"stockId"] integerValue];
        self.state = [dict[@"state"] integerValue];
        
        
        self.stateLabel = dict[@"stateLabel"];
        self.depotName = dict[@"depotName"];
        self.gimage = dict[@"gimage"];
        self.goodName = dict[@"goodName"];

        self.updateTime = dict[@"updateTime"];
        self.createTime = dict[@"createTime"];
        self.checkTime = dict[@"checkTime"];

    }
    return self;
}

-(NSString*)stateLabel
{
    if (_stateLabel.length == 0) {
        switch (self.state) {
            case 100:
                _stateLabel = @"待入库";
                break;
            case 200:
                _stateLabel = @"待放款";
                break;
            case 300:
                _stateLabel = @"在抵押";

                break;
            default:
                self.stateLabel = @"未知状态";
                break;
        }
    }
    
    return _stateLabel;
}

-(float)totalPrice
{
    return self.price * self.quantity;
}
@end

@implementation MortgageLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.content = dict[@"content"];
    }
    
    return self;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"【%@】%@\n %@", self.stateLabelNew, self.content, self.createTime];

}

@end


@implementation MortgageDetailDTO

@synthesize listDto = _listDto;
@synthesize logDtos = _logDtos ;

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.listDto = [[MortgageDTO alloc] initWith:dict];
        NSArray* logDtos = dict[@"logs"];
        
        NSMutableArray* logArray = [[NSMutableArray alloc] init];
        for (NSDictionary* log in logDtos) {
            MortgageLogDTO* logDto = [[MortgageLogDTO alloc] initWith:log];
            [logArray addObject:logDto];
        }
        
        self.logDtos = logArray;
    }
    
    return self;
}

@end
             
             
