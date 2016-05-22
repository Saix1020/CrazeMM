//
//  AddressInfoUpdater.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AddressInfo;

@interface AddressInfoUpdater : NSObject

/**
 *  全部地址
 *
 */
+ (NSArray *)totalAddressInfo;

/**
 *  当前选中地址
 *
 */

+ (void)update;

/**
 *  将默认地址设置为第一位
 */
+ (void)updateInfoforDefaultAddr:(AddressInfo *)info;
/**
 *  通过刷新整个数组来更新收货地址中选中使用的收货地址
 *
 *  @param infoArray 新的数组
 */
+ (void)setSelectedAddressInfoByNewInfoArray:(NSArray *)infoArray;
+ (void)addInfo:(AddressInfo *)info;
+ (void)removeInfoAtIndex:(NSUInteger)index;
+ (void)updateInfoAtIndex:(NSUInteger)index withInfo:(AddressInfo *)info;


@end
