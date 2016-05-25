//
//  ZoomOutUpAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "ZoomOutUpAnimation.h"

@implementation ZoomOutUpAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.4,@1];
    NSArray<CAMediaTimingFunction *> * timeFunctions  = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
                                                          [CAMediaTimingFunction functionWithControlPoints:0.550 : 0.055:0.675 :0.190],[CAMediaTimingFunction functionWithControlPoints:0.175 :0.885 :0.320 :1]];
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes = keyTimes;
    opacityAnimation.timingFunctions = timeFunctions;
    opacityAnimation.values = @[@1,@1,@0];
    
    ///transform animation
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes =keyTimes;
    transformAnimation.timingFunctions = timeFunctions;
    
    CATransform3D middleTransform = CATransform3DScale(_targetView.layer.transform, .475, .475, .475);
    middleTransform = CATransform3DTranslate(middleTransform, 0,60 , 0);
    
    CATransform3D endTransform = CATransform3DScale (_targetView.layer.transform, .1, .475, .475);
    endTransform = CATransform3DTranslate(endTransform, 0, -2000, 0);
    
    NSArray * values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:_targetView.layer.transform],
                        [NSValue valueWithCATransform3D:middleTransform],
                        [NSValue valueWithCATransform3D:endTransform], nil];
    
    transformAnimation.values= values;
    
    
    
    //animation group
    CAAnimationGroup * animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[opacityAnimation,transformAnimation];
    animationGroup.delegate= self;
    animationGroup.duration = _params.duration;
    
    [_targetView.layer addAnimation:animationGroup forKey:@""];
}

@end
