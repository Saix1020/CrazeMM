//
//  AnimationHelper.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/21.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "AnimationHelper.h"


static AnimationBuilder * animationBuilder;

@implementation AnimationHelper
+(AnimationBuilder *)defaultAnimationBuilder
{
    if(animationBuilder == nil){
        animationBuilder = [[AnimationBuilder alloc] init];
        [animationBuilder setDuration:2.0f];
    }
    return animationBuilder;
}


+(void)playAnimationOn:(UIView *)targetView
   animationType:(AnimationType)animationType
{
    AnimationBuilder * defaultAnimationBuilder  =  [self defaultAnimationBuilder];
    [defaultAnimationBuilder setAnimationType:animationType];
    [defaultAnimationBuilder startOn:targetView];
    
}

+(void)playAnimationOn:(UIView *)targetView
         animationType:(AnimationType)animationType
              delegate:(id)delegate
{
    AnimationBuilder * defaultAnimationBuilder  =  [self defaultAnimationBuilder];
    [defaultAnimationBuilder setAnimationType:animationType];
    [defaultAnimationBuilder setDelegate:delegate];
    [defaultAnimationBuilder startOn:targetView];
    
}


@end
