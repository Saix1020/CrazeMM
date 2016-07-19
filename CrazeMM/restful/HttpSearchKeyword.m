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

-(instancetype)initWithKeywords:(NSArray *)keywords andType:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        self.params = [@{
                         @"keywords" : [keywords componentsJoinedByString:@","],
                         @"type" : @(type)
                         } mutableCopy];
        
    }
    return self;
}

-(instancetype)initWithKeywords:(NSArray*)keywords andType:(NSInteger)type andMinPrice:(float)minPrice andMaxPrice:(float)maxPrice andBrands:(NSArray*)brands andColors:(NSArray*)colors andNetworks:(NSArray*)networks andVolumes:(NSArray*)volumes
{
    self = [super init];
    if (self) {
        
        self.params = [@{
                         @"keywords" : [keywords componentsJoinedByString:@","],
                         @"type" : @(type)
                         } mutableCopy];
        
    }
    
    if (minPrice>=0) {
        [self.params setValue:@(minPrice)
                       forKey:@"minprice"];
        
    }
    
    if (maxPrice>=0) {
        [self.params setValue:@(maxPrice)
                       forKey:@"maxprice"];
        
    }
    
    if (brands && brands.count>0) {
        [self.params setValue:[brands componentsJoinedByString:@","] forKey: @"brands"];
        
    }
    if (colors && colors.count>0) {
        [self.params setValue:[colors componentsJoinedByString:@","] forKey: @"colors"];
        
    }
    if (networks && networks.count>0) {
        [self.params setValue:[networks componentsJoinedByString:@","] forKey: @"network"];
        
    }
    if (volumes && volumes.count>0) {
        [self.params setValue:[volumes componentsJoinedByString:@","] forKey: @"volume"];
        
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
                         @"type" : cata==1?@"supply":@"buy"
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
