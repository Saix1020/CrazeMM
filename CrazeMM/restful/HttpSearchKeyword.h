//
//  HttpSearchKeyword.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpSearchAddKeywordsRequest : BaseHttpRequest

-(instancetype)initWithKeywords:(NSArray*)keywords;
-(instancetype)initWithKeywords:(NSArray *)keywords andType:(NSInteger)type; //1 supply, 2 buy

-(instancetype)initWithKeywords:(NSArray*)keywords andType:(NSInteger)type andMinPrice:(float)minPrice andMaxPrice:(float)maxPrice andBrands:(NSArray*)brands andColors:(NSArray*)colors andNetworks:(NSArray*)networks andVolumes:(NSArray*)volume;


@end

@interface HttpSearchRemoveKeywordsRequest : BaseHttpRequest

@end

@interface HttpSearchQueryKeywordsRequest : BaseHttpRequest

-(instancetype)initWithQueryCata:(NSInteger)cata; // 0: supply, 1 : buy

@end

@interface HttpSearchQueryKeywordsResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray* keywords;

@end