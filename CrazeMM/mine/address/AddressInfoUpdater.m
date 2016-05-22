//
//  AddressInfoUpdater.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressInfoUpdater.h"
#import "AddressInfo.h"

#define AddressInfosPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"addressInfo.data"]

@implementation AddressInfoUpdater


static NSMutableArray *_addressInfos;

+ (NSArray *)totalAddressInfo {
    _addressInfos = [NSKeyedUnarchiver unarchiveObjectWithFile:AddressInfosPath];
    NSLog(@"%@", AddressInfosPath);
    if (!_addressInfos) _addressInfos = [NSMutableArray array];
    return _addressInfos;
}

+ (void)update {
    [NSKeyedArchiver archiveRootObject:_addressInfos toFile:AddressInfosPath];
}

+ (void)updateInfoforDefaultAddr:(AddressInfo *)info {
    if (!_addressInfos.count)
    {
        _addressInfos = [NSMutableArray array];
        [AddressInfoUpdater addInfo:info];
    }
    else
    {
        for (AddressInfo *oldInfo in _addressInfos) {
            oldInfo.state = NO;
        }
        
        [AddressInfoUpdater insertInfo:info];
    }
}

+ (void)setSelectedAddressInfoByNewInfoArray:(NSArray *)infoArray {
    [NSKeyedArchiver archiveRootObject:infoArray toFile:AddressInfosPath];
}

+ (void)addInfo:(AddressInfo *)info {
    //add to the tail of addressinfos
    [_addressInfos addObject:info];
    [self update];
}

+ (void)insertInfo:(AddressInfo *)info {
    //add to the head of addressinfos
    [_addressInfos insertObject:info atIndex:0];
    [self update];
}

+ (void)removeInfoAtIndex:(NSUInteger)index {
    [_addressInfos removeObjectAtIndex:index];
    [self update];
}

+ (void)updateInfoAtIndex:(NSUInteger)index withInfo:(AddressInfo *)info {
    [_addressInfos replaceObjectAtIndex:index withObject:info];
    [self update];
}

@end
