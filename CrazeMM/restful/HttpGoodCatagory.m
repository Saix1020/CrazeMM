//
//  HttpGoodCatagory.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpGoodCatagory.h"

@implementation HttpGoodColorRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/good/color");
}

-(Class)responseClass
{
    return [HttpGoodColorResponse class];
}

@end

@implementation HttpGoodColorResponse

-(void)parserResponse
{
    self.colors = self.all?self.all[@"color"]:nil;
}

@end


@implementation HttpGoodNetworkRequest
-(NSString*)url
{
    return COMB_URL(@"/rest/good/network");
}
-(Class)responseClass
{
    return [HttpGoodNetworkResponse class];
}


@end

@implementation HttpGoodNetworkResponse

-(void)parserResponse
{
    self.networks = self.all?self.all[@"network"]:nil;
}

@end


@implementation HttpGoodVolumeRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/good/volume");
}
-(Class)responseClass
{
    return [HttpGoodVolumeResponse class];
}

@end
@implementation HttpGoodVolumeResponse

-(void)parserResponse
{
    self.volums = self.all?self.all[@"volume"]:nil;
}

@end
