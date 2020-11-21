//
//  HttpSupplyRequest.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "HttpSearchRequest.h"
#import "SupplyProductDTO.h"

@interface HttpSupplyRequest : HttpSearchRequest

-(instancetype)initWithPageNumber:(NSUInteger)pageNumber;

//@property (nonatomic)  NSInteger pageNumber;

//http://b.189mm.com/rest/supply?pn=1&keywords=&minprice=&maxprice=&brands=&colors=&network=&volume=&sort=


@end

@interface HttpSupplyResponse : HttpSearchResponse

//@property (nonatomic, readonly) NSString* createTime;
//@property  (nonatomic, readonly) NSString* goodImage;

@end


