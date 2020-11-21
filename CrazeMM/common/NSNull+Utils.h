//
//  NSNull+Utils.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/8.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (Utils)
@property (nonatomic, readonly) NSInteger length;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSString* description;

//@property (nonatomic, readonly) NSString* description;
-(NSInteger)integerValue;

- (void)setValue:(nullable id)value forKey:(NSString *)key;
- (nullable id)valueForKey:(NSString *)key;

@end
