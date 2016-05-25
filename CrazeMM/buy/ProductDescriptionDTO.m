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
        //self.createTime = [NSDate date];
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



+(ProductDescriptionDTO*)mockDate
{
    ProductDescriptionDTO * mock = [[ProductDescriptionDTO alloc] init];
    srand(time(NULL));
    
    mock.goodImage = @[@"http://www.189mm.com:8080/upload/good/1475.jpg", @"http://www.189mm.com:8080/upload/good/1647.png?_=3b9619dcc788ed6ef05b916a4f6692a3", @"http://www.189mm.com:8080/upload/good/1705.png?_=781962cd0d057171985ca3cc834f99cd"][arc4random()%3];
    mock.goodName = arc4random()%2?@"飞利浦 -V387 黑色 ":@"飞利浦 -V387 黑";
    mock.id = arc4random()%1000 + 1000;
    mock.stateLabel = @"正常";
    mock.price = 2000 + arc4random()%2000 + ((double)(1000+arc4random()%1000))/2000;
    mock.quantity = arc4random()%10 + 10;
    mock.canSplit = arc4random()%2;
    mock.duration = (arc4random()%4)*(3600*24) + 768*(arc4random()%10);
    //mock.createTime = @"2016-03-01 12:00:00";
    
    return mock;
}

@end
