//
//  HttpSupplyNoLoginRequest.m
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSupplyNoLoginRequest.h"

@implementation HttpSupplyNoLoginRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/supply/top");
}

@end
