//
//  BaseDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDTO : NSObject

//@property (nonatomic, strong) RACSignal* rac_signal;
@property (nonatomic) NSInteger id;


-(instancetype)initWith:(NSDictionary*)dict;
-(void)parserResponse;
-(NSDictionary *)encode;
//+(NSDictionary*)validateDict:(NSDictionary*)dict;


@end


@interface BaseListDTO : BaseDTO

@property (nonatomic) BOOL selected;
@property (nonatomic, readonly) float totalPrice;


@end

@interface BaseLogDTO : BaseDTO

@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger oldState;
@property (nonatomic) NSInteger oid;
@property (nonatomic) NSInteger newState;
@property (nonatomic, copy) NSString* stateLabelNew;
@property (nonatomic, copy) NSString* createTime;

@end

@protocol BaseDetailDTO <NSObject>

@property (nonatomic, strong) BaseListDTO* listDto;
@property (nonatomic, strong) NSArray* logDtos;

@end