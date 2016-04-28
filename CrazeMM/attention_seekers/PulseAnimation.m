//
//  PulseAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "PulseAnimation.h"

@implementation PulseAnimation

-(void)prepare
{
        NSArray<NSNumber *> *keyTimes =  @[@0,@0.5,@1];
        CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnimation.keyTimes = keyTimes;
    
        CATransform3D beginTransform = CATransform3DScale(_targetView.layer.transform, 1, 1, 1);
        CATransform3D middleTransform = CATransform3DScale(_targetView.layer.transform, 1.05, 1.05, 1.05);
        CATransform3D endTransform = CATransform3DScale(_targetView.layer.transform, 1, 1, 1);
    
        transformAnimation.values = @[[NSValue valueWithCATransform3D:beginTransform],
                                   [NSValue valueWithCATransform3D:middleTransform],
                                  [NSValue valueWithCATransform3D:endTransform]
                                  ];
    
    
    _animationGroup.animations = @[transformAnimation];

    
    
 }

@end
