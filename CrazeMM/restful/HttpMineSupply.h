//
//  HttpMineSupply.h
//  CrazeMM
//
//  Created by saix on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "MineSupplyProductDTO.h"

typedef NS_ENUM(NSInteger, MMMineSupplyState){
    kStateNomal = 100,
    kStateMortgage = 101,
    kStateSoldOut = 200,
    kStateCanceled = 400,
    kStateOverdua = 500
};

@interface HttpMineSupplyRequest : BaseHttpRequest

-(instancetype)initWithPageNumber:(NSInteger)pageNumber andState:(NSArray*)states;
-(instancetype)initStateOffShelfWithPageNumber:(NSInteger)pageNumber;
-(instancetype)initStateSoldOutWithPageNumber:(NSInteger)pageNumber;
-(instancetype)initStateNomalWithPageNumber:(NSInteger)pageNumber;

@end

@interface HttpMineSupplyResponse : BaseHttpResponse //

@property (nonatomic, readonly) NSArray* productList;
@property (nonatomic, readonly) NSUInteger pageNumber;
@property (nonatomic, readonly) NSUInteger totalPage;
@property (nonatomic, readonly) NSUInteger totalRow;
@property (nonatomic, strong) NSMutableArray* productDTOs;
@property (nonatomic, readonly) NSArray* nomalProductDtos;
@property (nonatomic, readonly) NSArray* offShelfProductDtos;
@property (nonatomic, readonly) NSArray* dealProductDtos;

@end

@interface HttpMineBuyRequest : HttpMineSupplyRequest

@end


//{"page":{"totalRow":1,"pageNumber":1,"totalPage":1,"pageSize":10,"list":[{"isAnoy":false,"quantity":10,"address":"江苏-南京-鼓楼区 山西路68号27FAB座","millisecond":73351206,"deadlineStr":"72小时以上","intentions":0,"updateTime":"2016-05-20 17:47:30","userName":"xuanxuan","isActive":true,"duration":24,"userImage":"http:\/\/www.189mm.com:8080\/upload\/user\/4_cut.jpg","goodName":"小米-4C 白色 16G 全网通高配版","createTime":"2016-05-20 17:47:30","price":110.00,"stateLabel":"正常","id":296,"state":100,"views":0}]},"ok":true}
@interface HttpMineBuyResponse : HttpMineSupplyResponse


@end
