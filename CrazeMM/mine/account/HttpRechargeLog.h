//
//  HttpRechargeLog.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "HttpListQuery.h"
#import "RechargeLogDTO.h"

@interface HttpRechargeLogRequest : HttpListQueryRequest

@end

//{"page":{"totalRow":4,"pageNumber":1,"totalPage":1,"pageSize":10,"list":[{"no":160610361819444,"uid":4,"auid":null,"methodDesc":"个人网银","money":1.00,"method":1,"createTime":"2016-06-10 10:03:04","stateDesc":"充值中","updateTime":"2016-06-10 10:03:04","comment":null,"id":15,"state":100},{"no":160610352693444,"uid":4,"auid":null,"methodDesc":"个人网银","money":1.00,"method":1,"createTime":"2016-06-10 09:48:04","stateDesc":"充值中","updateTime":"2016-06-10 09:48:04","comment":null,"id":14,"state":100},{"no":160610346178094,"uid":4,"auid":null,"methodDesc":"个人网银","money":1.00,"method":1,"createTime":"2016-06-10 09:37:03","stateDesc":"充值中","updateTime":"2016-06-10 09:37:03","comment":null,"id":13,"state":100},{"no":160610303626924,"uid":4,"auid":null,"methodDesc":"个人网银","money":100.00,"method":1,"createTime":"2016-06-10 08:26:04","stateDesc":"充值中","updateTime":"2016-06-10 08:26:04","comment":null,"id":12,"state":100}]},"ok":true}
@interface HttpRechargeLogResponse : HttpListQueryResponse


@end