//
//  UIBarButtonItem+FontAwesome.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIBarButtonItem+FontAwesome.h"
#import "UIButton+PPiAwesome.h"
#import "UIButton+Utils.h"

@implementation UIBarButtonItem (FontAwesome)

+(UIBarButtonItem*)filterBarButtonItem
{
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    UIButton* button = [UIButton filterButtonAwesome];
    barButtonItem.customView = button;
    
    return barButtonItem;
}

+(UIBarButtonItem*)filterBarButtonItemWithTaget:(id)target andAction:(SEL)action
{
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    UIButton* button = [UIButton filterButtonAwesome];

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    barButtonItem.customView = button;
    
    return barButtonItem;
}

+(UIBarButtonItem*)filterBarButtonItemWithBlock:(signalBlock)block
{
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    UIButton* button = [UIButton filterButtonAwesome];
    button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if(block) {
            block(input);
        }
        return [RACSignal empty];
    }];
    barButtonItem.customView = button;
    
    return barButtonItem;
}

@end

