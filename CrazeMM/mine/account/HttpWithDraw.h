//
//  HttpWithDraw.h
//  CrazeMM
//
//  Created by saix on 16/6/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpWithDrawRequest : BaseHttpRequest

-(instancetype)initWithBid:(NSInteger)bid andPassword:(NSString*)password andAmount:(CGFloat)amount;


@end
