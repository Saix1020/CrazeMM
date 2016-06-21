//
//  HttpMineSupply.h
//  CrazeMM
//
//  Created by saix on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "MineSupplyProductDTO.h"
#import "SupplyDetailDTO.h"

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



@interface HttpMineStockRequest : BaseHttpRequest

-(instancetype)initWithPageNumber:(NSInteger)pageNumber;
-(instancetype)initWithPageNumber:(NSInteger)pageNumber andStatus:(NSString*)status;

@end

/*
 {
 "page": {
 "totalRow": 6,
 "pageNumber": 1,
 "totalPage": 1,
 "pageSize": 10,
 "list": [{
 "gid": 1666,
 "depot": {
 "name": "良晋栖霞仓库",
 "id": 2,
 "info": "位于江苏省南京市栖霞区"
 },
 "inprice": 2999,
 "depotId": 2,
 "updateTime": "2016-05-31 22:59:09",
 "presale": 1000,
 "aftersale": 0,
 "gvolume": "16G",
 "version": 0,
 "isSerial": true,
 "uid": 366,
 "isOriginal": true,
 "goodName": "苹果-iPhone SE 粉 16G 全网通",
 "gcolor": "粉",
 "isOriginalBox": true,
 "id": 16,
 "insale": 0,
 "gnetwork": "全网通",
 "isBrushMachine": false
 }]
 },
 "ok": true
 }
 */

@interface HttpMineStockResponse : BaseHttpResponse


@property (nonatomic, readonly) NSArray* stockList;
@property (nonatomic, readonly) NSUInteger pageNumber;
@property (nonatomic, readonly) NSUInteger totalPage;
@property (nonatomic, readonly) NSUInteger totalRow;
@property (nonatomic, strong) NSMutableArray* stockDTOs;

@end

@interface HttpMineStockDetailRequest : BaseHttpRequest

@property (nonatomic) NSInteger sid;
-(instancetype)initWithId:(NSInteger)sid;

@end

//{"ok":true,"supply":{"deadlineStr":"72小时以上","millisecond":-1,"isSerial":true,"duration":0,"goodName":"步步高-5263 白 4GB 电信版","price":1600.00,"isOriginalBox":true,"id":1935,"state":400,"isBrushMachine":true,"logs":[{"afterState":400,"createTime":"2016-06-21 20:05:59","beforeState":100,"id":579,"message":"用户下架供货","newStateLabel":"已下架","sid":1935},{"afterState":100,"createTime":"2016-06-06 22:24:44","beforeState":0,"id":352,"message":"库存76转手供货保存","newStateLabel":"在售","sid":1935}],"views":5,"isSplit":false,"quantity":10,"active":false,"intentions":3,"message":null,"version":0,"isOriginal":true,"left":10,"createTime":"2016-06-06 22:24:44","isTop":true,"stateLabel":"已下架","region":"不限","user":{"typeName":"个人","id":4,"validateState":300,"username":"xuanxuan"},"isStep":false}}
@interface HttpMineStockDetailResponse : BaseHttpResponse

@property (nonatomic, readonly) NSDictionary* supply;
@property (nonatomic, strong) MineSupplyDetailDTO* supplyDtailDto;
@end
