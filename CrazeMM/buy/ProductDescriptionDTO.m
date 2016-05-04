//
//  ProductDescriptionDTO.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductDescriptionDTO.h"

@implementation ProductDescriptionDTO

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.createTime = [NSDate date];
        self.elapseTime = 0;
        
        [[MMTimer sharedInstance].oneSecondSignal subscribeNext:^(id x){
            NSDate* now = [NSDate date];
            NSTimeInterval interval = [now timeIntervalSinceDate:self.createTime];
            self.elapseTime = (int)interval*60;
            
//            [self.rac_signal 
        }];
    }
    
    return self;
}

-(instancetype)initWith:(NSDictionary*)dict
{
    self = [self init];
//
    if (self) {
        self.id = [dict[@"id"] integerValue];
        self.deadlineStr = dict[@"deadlineStr"];
        self.goodName = dict[@"goodName"];
        self.region = dict[@"region"];
        self.stateLabel = dict[@"stateLabel"];
        self.userImage = dict[@"userImage"];
        self.userName = dict[@"userName"];
        self.duration = [dict[@"duration"] integerValue];
        self.intentions = [dict[@"intentions"] integerValue];
        self.isActive = [dict[@"isActive"] boolValue];
        self.isAnoy = [dict[@"isAnoy"] boolValue];
        self.millisecond = [dict[@"millisecond"] integerValue];
        self.isStep = [dict[@"isStep"] boolValue];
        self.price = [dict[@"price"] integerValue];
        self.quantity = [dict[@"quantity"] integerValue];
        self.views = [dict[@"views"] integerValue];

    }
    
    return self;
}


-(NSString*)miniumPriceString1
{
    int result = (int)floor(self.minimumPrice);
    return [NSString stringWithFormat:@"%d", result];
    
}

-(NSString*)miniumPriceString2
{
    int result = (int)floor((self.minimumPrice - (int)floor(self.minimumPrice))*100);
    return [NSString stringWithFormat:@".%02d", result];
    
}

-(NSString*)minimumNumberString
{
    return [NSString stringWithFormat:@"%lu", self.minimumNumber];
}



+(ProductDescriptionDTO*)mockDate
{
    ProductDescriptionDTO * mock = [[ProductDescriptionDTO alloc] init];
    srand(time(NULL));
    
    mock.imageURL = @[@"http://10.157.10.84:9989/image/dog.png", @"http://10.157.10.84:9989/image/trashcan.jpg", @"http://10.157.10.84:9989/image/channelOne_logo1.png"][arc4random()%3];
    mock.title = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    mock.id = arc4random()%1000 + 1000;
    mock.status = @"正常";
    mock.minimumPrice = 2000 + arc4random()%2000 + ((double)(1000+arc4random()%1000))/2000;
    mock.minimumNumber = arc4random()%10 + 10;
    mock.canSplit = arc4random()%2;
    mock.remainingTime = (arc4random()%4)*(3600*24) + 768*(arc4random()%10);
    
    return mock;
}

-(NSString*)description
{
    NSString* desc = [NSString stringWithFormat:
                      @"id : %lu\n"
                      "deadlineStr: %@\n"
                      "goodName : %@\n"
                      "region : %@\n"
                      "stateLabel : %@\n"
                      "userImage : %@\n"
                      "userName : %@\n"
                      "duration:%ld\n"
                      "intentions:%ld\n"
                      "isActive:%d\n"
                      "isAnoy:%d\n"
                      "isStep:%d\n"
                      "millisecond:%ld\n"
                      "price:%ld\n"
                      "quantity:%ld\n"
                      "views:%ld"
                      ,self.id
                      ,self.deadlineStr, self.goodName, self.region,
                      self.stateLabel, self.userImage, self.userName,
                      self.duration, self.intentions, self.isActive,
                      self.isAnoy, self.isStep, self.millisecond,
                      (long)self.price, self.quantity, (long)self.views];
    
    return desc;

}

@end
