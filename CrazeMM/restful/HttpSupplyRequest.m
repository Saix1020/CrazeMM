//
//  HttpSupplyRequest.m
//  CrazeMM
//
//  Created by saix on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSupplyRequest.h"
#import "ProductDescriptionDTO.h"

@implementation HttpSupplyRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/supply");
}


-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpSupplyResponse class];
}


@end


@implementation HttpSupplyResponse


//{
//    ok = 1;
//    page =     {
//        list =         (
//                        {
//                            deadlineStr = "72\U5c0f\U65f6\U4ee5\U4e0a";
//                            duration = 24;
//                            goodName = "\U82f9\U679c-iPhone SE \U7c89 16G \U5168\U7f51\U901a";
//                            id = 1660;
//                            intentions = 1;
//                            isActive = 1;
//                            isAnoy = 0;
//                            isStep = 0;
//                            millisecond = 48977492;
//                            price = 1;
//                            quantity = 10;
//                            region = "\U4e0a\U6d77";
//                            stateLabel = "\U6b63\U5e38";
//                            userImage = "http://www.189mm.com:8080/upload/user/1_cut.jpg";
//                            userName = 189mm;
//                            views = 5;
//                        },
//                          ....
//                        );
//        pageNumber = 1;
//        pageSize = 10;
//        totalPage = 135;
//        totalRow = 1341;
//    };
//}


@end
