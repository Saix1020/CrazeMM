//
//  HttpSearchKeyword.m
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSearchKeyword.h"

@implementation HttpSearchAddKeywordsRequest

-(instancetype)initWithKeywords:(NSArray *)keywords
{
    self = [super init];
    if (self) {
        
        self.params = [@{
                         @"keywords" : [keywords componentsJoinedByString:@","],
                         @"type" : @(1)
                         } mutableCopy];
        
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/search/addSearch");
}

-(NSString*)method
{
    return @"GET";
}

@end


@implementation HttpSearchRemoveKeywordsRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/search/removeAll");
}

-(NSString*)method
{
    return @"GET";
}

@end

@implementation HttpSearchQueryKeywordsRequest 

-(instancetype)initWithQueryCata:(NSInteger)cata
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"type" : cata==0?@"supply":@"buy"
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/search");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpSearchQueryKeywordsResponse class];
}

@end

@implementation HttpSearchQueryKeywordsResponse

-(void)parserResponse
{
    self.keywords = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in self.all[@"search"]) {
        [self.keywords addObject:dict[@"content"]];
    }
}

@end
