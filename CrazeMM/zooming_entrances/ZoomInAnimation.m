//
//  ZoomInAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/21.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "ZoomInAnimation.h"

@implementation ZoomInAnimation


-(void)prepare
{
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes = @[@0,@0.5,@1];
    opacityAnimation.values=@[@0,@1,@1];
    
    
    CAKeyframeAnimation * transformScaleAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D startingScale = CATransform3DScale (_targetView.layer.transform, .3, .3, .3);
    CATransform3D middleScale = CATransform3DScale (_targetView.layer.transform, 1, 1, 1);
    CATransform3D endingScale = CATransform3DScale (_targetView.layer.transform, 1, 1, 1);
    
    NSArray * scales = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:startingScale],
                        [NSValue valueWithCATransform3D:middleScale],
                        [NSValue valueWithCATransform3D:endingScale], nil];
    transformScaleAnimation.keyTimes = @[@0,@0.5,@1];
    transformScaleAnimation.values=scales;
    
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    _animationGroup.animations = @[opacityAnimation,transformScaleAnimation];
    
}


@end
