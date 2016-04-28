//
//  ZoomOutLeftAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "ZoomOutLeftAnimation.h"

@implementation ZoomOutLeftAnimation

-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.4,@1];


    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes = keyTimes;
    opacityAnimation.values = @[@1,@1,@0];
    
    ///transform scale translate animation
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes =keyTimes;
    
    CATransform3D middleTransform = CATransform3DScale(_targetView.layer.transform, .475, .475, .475);
    middleTransform = CATransform3DTranslate(middleTransform, 42,0 , 0);
    
    CATransform3D endTransform = CATransform3DScale (_targetView.layer.transform, .1, .475, .475);
    endTransform = CATransform3DTranslate(endTransform, -2000, 0, 0);
    
    NSArray * scales = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:_targetView.layer.transform],
                        [NSValue valueWithCATransform3D:middleTransform],
                        [NSValue valueWithCATransform3D:endTransform], nil];
    
    transformAnimation.values= scales;
    
    
    
    //animation group
    _animationGroup = [[CAAnimationGroup alloc] init];
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
}

@end
