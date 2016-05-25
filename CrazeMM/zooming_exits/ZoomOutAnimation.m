//
//  ZoomOutAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/17.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "ZoomOutAnimation.h"

@implementation ZoomOutAnimation

-(void)prepare
{
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes = @[@0,@0.5,@1];
    opacityAnimation.values=@[@1,@0,@0];

    
    CAKeyframeAnimation * transformScaleAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D startingScale = CATransform3DScale (_targetView.layer.transform, 1, 1, 1);
    CATransform3D middleScale = CATransform3DScale (_targetView.layer.transform, .3, .3, .3);
    CATransform3D endingScale = CATransform3DScale (_targetView.layer.transform, .3, .3, .3);
    
    NSArray * scales = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:startingScale],
                             [NSValue valueWithCATransform3D:middleScale],
                             [NSValue valueWithCATransform3D:endingScale], nil];
    transformScaleAnimation.keyTimes = @[@0,@0.5,@1];
    transformScaleAnimation.values=scales;
    
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    _animationGroup.animations = @[opacityAnimation,transformScaleAnimation];

}


@end
