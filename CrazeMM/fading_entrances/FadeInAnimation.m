//
//  FadeInAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "FadeInAnimation.h"

@implementation FadeInAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@0,@1];
    
    
    _animationGroup.animations = @[opacityAnimation];
    _animationGroup.duration = _params.duration;
    _animationGroup.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];

}

@end
