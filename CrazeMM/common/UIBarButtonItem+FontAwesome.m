//
//  UIBarButtonItem+FontAwesome.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIBarButtonItem+FontAwesome.h"
#import "UIButton+PPiAwesome.h"

#define kHightLightColor ([UIColor colorWithRed:255 green:255 blue:255 alpha:0.2])

@implementation UIBarButtonItem (FontAwesome)

+(UIButton*)filterButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom text:@"" icon:@"icon-filter" textAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:[UIColor whiteColor]} andIconPosition:IconPositionRight];
    [button setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:kHightLightColor} forUIControlState:UIControlStateHighlighted];
    [button sizeToFit];
    
    return button;
}

+(UIBarButtonItem*)filterBarButtonItem
{
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    UIButton* button = [UIBarButtonItem filterButton];
    barButtonItem.customView = button;
    
    return barButtonItem;
}

+(UIBarButtonItem*)filterBarButtonItemWithTaget:(id)target andAction:(SEL)action
{
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    UIButton* button = [UIBarButtonItem filterButton];

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    barButtonItem.customView = button;
    
    return barButtonItem;
}

+(UIBarButtonItem*)filterBarButtonItemWithBlock:(signalBlock)block
{
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    UIButton* button = [UIBarButtonItem filterButton];
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

