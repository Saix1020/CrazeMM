//
//  FlashAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "FlashAnimation.h"

@implementation FlashAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.25,@0.5,@0.75,@1];
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes = keyTimes;
    opacityAnimation.values = @[@1,@0,@1,@0,@1];
    
    
    _animationGroup.animations = @[opacityAnimation];

    
    
}

@end
