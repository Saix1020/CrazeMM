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


//@property (nonatomic, copy) NSString* imageURL;
//@property (nonatomic, copy) NSString* title;
//@property (nonatomic) NSUInteger id;
//@property (nonatomic, copy) NSString* status;
//@property (nonatomic) NSUInteger remainingTime;
//@property (nonatomic, strong) NSDate* createTime;
//@property (nonatomic, readonly) NSString* detail;
//@property (nonatomic) double minimumPrice;
//@property (nonatomic) NSUInteger minimumNumber;

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

@end
