//
//  BaseDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDTO : NSObject

//@property (nonatomic, strong) RACSignal* rac_signal;
@property (nonatomic) NSInteger id;


-(instancetype)initWith:(NSDictionary*)dict;
-(void)parserResponse;
-(NSDictionary *)encode;

@end


@interface BaseListDTO : BaseDTO

@property (nonatomic) BOOL selected;
@property (nonatomic, readonly) float totalPrice;
@end