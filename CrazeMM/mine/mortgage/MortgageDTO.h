//
//  MortgageDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
//{"interestRate":1.0E-4,"depotName":"良晋总仓库","quantity":1,"gid":1732,"gimage":null,"updateTime":"2016-06-29 23:13:14","duration":30,"outPrice":101,"checkUid":null,"checkTime":null,"goodName":"锤子-AAAA DV 43 FDD","createTime":"2016-06-29 23:13:14","debtMoney":null,"price":2000.00,"stockId":220,"stateLabel":"待入库","id":23,"state":100}
@interface MortgageDTO : BaseListDTO

@property (nonatomic) float interestRate;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger gid;
@property (nonatomic) NSInteger duration;
@property (nonatomic) float outPrice;
@property (nonatomic) float price;
@property (nonatomic) NSInteger stockId;
@property (nonatomic) NSInteger state;

@property (nonatomic, copy) NSString* stateLabel;
@property (nonatomic, copy) NSString* depotName;
@property (nonatomic, copy) NSString* gimage;
@property (nonatomic, copy) NSString* updateTime;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic, copy) NSString* createTime;

@end


@interface MortgageDetailDTO : BaseDTO<BaseDetailDTO>

@property (nonatomic, strong) MortgageDTO* infoDto;
@property (nonatomic, strong) NSMutableArray* logDtos;


@end

@interface MortgageLogDTO : BaseLogDTO

@property(nonatomic, copy) NSString* content;



@end
