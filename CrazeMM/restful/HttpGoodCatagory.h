//
//  HttpGoodCatagory.h
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpGoodColorRequest : BaseHttpRequest


@end

@interface HttpGoodColorResponse : BaseHttpResponse

@property (nonatomic, copy) NSArray* colors;

@end

@interface HttpGoodNetworkRequest : BaseHttpRequest


@end

@interface HttpGoodNetworkResponse : BaseHttpResponse

@property (nonatomic, copy) NSArray* networks;

@end


@interface HttpGoodVolumeRequest : BaseHttpRequest


@end

@interface HttpGoodVolumeResponse : BaseHttpResponse

@property (nonatomic, copy) NSArray* volums;

@end
