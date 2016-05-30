//
//  HttpSearchKeyword.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpSearchAddKeywordsRequest : BaseHttpRequest

-(instancetype)initWithKeywords:(NSArray*)keywords;

@end

@interface HttpSearchRemoveKeywordsRequest : BaseHttpRequest

@end

@interface HttpSearchQueryKeywordsRequest : BaseHttpRequest

-(instancetype)initWithQueryCata:(NSInteger)cata; // 0: supply, 1 : buy

@end

@interface HttpSearchQueryKeywordsResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray* keywords;

@end