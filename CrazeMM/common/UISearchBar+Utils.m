//
//  UISearchBar+Utils.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UISearchBar+Utils.h"
#define kTimeAnimationDurationDefault 0.3

@implementation UISearchBar (Utils)

- (void)animateToEnabledState:(BOOL)enabled
{
    self.userInteractionEnabled=enabled;
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:kTimeAnimationDurationDefault];
    self.alpha = enabled ? 1.0f : 0.5f;
    [UIView commitAnimations];
    
}

@end
