//
//  HttpBuyRequest.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSearchRequest.h"

@interface HttpBuyRequest : HttpSearchRequest

@property (nonatomic)  NSInteger pageNumber;

-(instancetype)initWithPageNumber:(NSUInteger)pageNumber;
@end

@interface HttpBuyResponse : HttpSearchResponse

//@property (nonatomic, readonly) NSString* createTime;
//@property  (nonatomic, readonly) NSString* goodImage;

@end
