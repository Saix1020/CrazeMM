//
//  UIBarButtonItem+FontAwesome.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^signalBlock)(id data);


@interface UIBarButtonItem (FontAwesome)

+(UIBarButtonItem*)filterBarButtonItemWithTaget:(id)target andAction:(SEL)action;
+(UIBarButtonItem*)filterBarButtonItemWithBlock:(signalBlock)block;
+(UIBarButtonItem*)filterBarButtonItem;


@end
