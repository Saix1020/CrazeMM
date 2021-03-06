//
//  HttpSearchRequest.m
//  CrazeMM
//
//  Created by saix on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSearchRequest.h"

@implementation HttpSearchRequest

//@property (nonatomic) NSUInteger pageNumber;
//@property (nonatomic, copy) NSArray* keywords;
//@property (nonatomic) SearchSortType sortType;
//@property (nonatomic) SearchCategory categrory;

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.pageNumber = 1;
        self.sortType = kComprehensiveSortType;
        self.categrory = kSupplySearch;
        self.keywords = [[NSArray alloc] init];
        
        self.params =  [@{
                          @"pn" : @(self.pageNumber),
                          @"keywords" : [self.keywords componentsJoinedByString:@","],
                          @"sort" : @(self.sortType)
                          } mutableCopy];;
        
    }
    
    return self;
}

-(instancetype)initWithPageNumber:(NSUInteger)pageNumber andKeywords:(NSArray*)keywords andSorts:(SearchSortType)sortType andCategory:(SearchCategory)categrory
{
    self = [super init];
    if (self) {
        self.pageNumber = pageNumber;
        self.sortType = sortType;
        self.categrory = categrory;
        self.keywords = keywords;
        
        self.params =  [@{
                          @"pn" : @(self.pageNumber),
                          } mutableCopy];
        if (self.keywords && self.keywords.count>0) {
            [self.params setValue:[self.keywords componentsJoinedByString:@","] forKey: @"keywords"];
        }
        if (self.sortType != kComprehensiveSortType) {
            [self.params setValue:@(self.sortType)
                           forKey:@"sort"];
        }
    }
    
    return self;
}

-(NSString*)url
{
    if (self.categrory == kSupplySearch) {
        return COMB_URL(@"/rest/supply");
    }
    else {
        return COMB_URL(@"/rest/buy");
    }
}
-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpSearchResponse class];
}


@end

@implementation HttpSearchResponse

//-(instancetype)initWith:(NSDictionary *)response
//{
//    self = [super initWith:response];
//    if (self) {
//        [self parserResponse];
//    }
//    return self;
//}

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.productDTOs = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.productList) {
        SearchResultDTO* dto = [[SearchResultDTO alloc] initWith:dict];
        NSLog(@"%@", dto);
        [self.productDTOs  addObject:dto];
    }
    
}

-(NSUInteger)pageNumber
{
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"pageNumber"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalPage
{
    
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"totalPage"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalRow
{
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"totalRow"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSArray*)productList
{
    if (self.all && self.all[@"page"]) {
        NSArray* productsList = self.all[@"page"][@"list"];
        return productsList;
    }
    
    return @[];
}


@end
