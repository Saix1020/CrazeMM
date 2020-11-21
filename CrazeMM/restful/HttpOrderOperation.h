//
//  HttpOrderOperation.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpBaseOrderOperationRequest : BaseHttpRequest

@property (nonatomic) NSMutableArray* oids;
-(instancetype)initWithOid:(NSInteger)oid;
-(instancetype)initWithOids:(NSArray*)oids;
@end

@interface HttpOrderReactiveRequest : HttpBaseOrderOperationRequest

@end

@interface HttpOrderReceiveRequest : HttpBaseOrderOperationRequest

@end

@interface HttpOrderSendRequest : HttpBaseOrderOperationRequest

-(instancetype)initWithOids:(NSArray *)oids andCheckoutMethod:(NSInteger)checkoutMethod andAccount:(NSInteger)account andLogisId:(NSInteger)logisId andLogisName:(NSString*)logisName andOrderCode:(NSString*)orderCode;

@end

@interface HttpOrderConfirmRequest : HttpBaseOrderOperationRequest

@end

@interface HttpOrderLogicDelete : HttpBaseOrderOperationRequest

@end
@interface HttpSingleOrderLogicDelete : HttpBaseOrderOperationRequest

@end