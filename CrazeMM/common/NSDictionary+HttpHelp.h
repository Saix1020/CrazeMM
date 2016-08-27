//
//  NSDictionary+HttpHelp.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HttpHelp)
@property (nonatomic, readonly) BOOL ok;
@property (nonatomic, readonly) NSString* msg;
@property (nonatomic, readonly) NSData* data;
@end
