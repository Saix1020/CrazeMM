//
//  HttpOrderSummary.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/5.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpOrderSummaryRequest : BaseHttpRequest




@end

@interface HttpOrderSummaryResponse : BaseHttpResponse

@property (nonatomic, readonly) NSDictionary* state;
@property (nonatomic, readonly) NSDictionary* sum;
@property (nonatomic, readonly) NSDictionary* buy;
@property (nonatomic, readonly) NSDictionary* supply;
@property (nonatomic, readonly) NSInteger tobepaid;
@property (nonatomic, readonly) NSInteger tobereceived;
@property (nonatomic, readonly) NSInteger tobesent;
@property (nonatomic, readonly) NSInteger tobeconfirmed;

@end