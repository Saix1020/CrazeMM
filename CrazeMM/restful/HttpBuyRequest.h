//
//  HttpBuyRequest.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSearchRequest.h"
#import "HttpSupplyRequest.h"

@interface HttpBuyRequest : HttpSearchRequest

@property (nonatomic)  NSInteger pageNumber;

-(instancetype)initWithPageNumber:(NSUInteger)pageNumber;
@end

@interface HttpBuyResponse : HttpSearchResponse

//@property (nonatomic, readonly) NSString* createTime;
//@property  (nonatomic, readonly) NSString* goodImage;

@end

@interface HttpBuyDetailRequest : BaseHttpRequest

@end

@interface HttpBuyDetailResponse : BaseHttpResponse

//{"buy":{"isAnoy":false,"quantity":1,"goodImage":"https:\/\/static.189mm.net\/good\/1671.png?_=26216d1264667a8d78d1c7bc268495d9","deadlineStr":"24小时","millisecond":-667370480,"active":false,"intentions":0,"message":null,"version":1,"isSerial":true,"duration":24,"isOriginal":true,"goodName":"老来宝-620V 黑 .. 电信版","price":221.00,"isTop":false,"stateLabel":"已过期","isOriginalBox":true,"id":318,"state":500,"addr":{"zipCode":"200070","mobile":"18916660616","pid":25,"uid":56,"isDefault":false,"deleted":false,"phone":"021-62600201","street":"天目西路547号大奥通讯城2楼42-43号","contact":"张建林","id":51,"region":"上海-上海-闸北区","did":2704,"cid":321},"isBrushMachine":false,"user":{"typeName":"企业","successOrderCount":11,"id":56,"validateState":300,"username":"上海卓瓦实业有限公司"},"logs":[{"afterState":100,"createTime":"2016-08-26 14:24:22","beforeState":0,"id":13,"bid":318,"message":"用户发布求购信息","newStateLabel":"正常"}],"views":0},"ok":true}

//@property (nonatomic, strong) 
@end



@interface HttpBuyForMidifyRequest : HttpSupplyForMidifyRequest

@end


@interface HttpBuyForMidifyResponse : HttpSupplyForMidifyResponse

@end


