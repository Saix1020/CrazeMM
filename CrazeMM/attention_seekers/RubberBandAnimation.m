//
//  RubberBandAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "RubberBandAnimation.h"

@implementation RubberBandAnimation

-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.3,@0.4,@0.5,@0.65,@0.75,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D originTransform = _targetView.layer.transform;

    
    transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DScale(originTransform, 1, 1,1 )],
                                  [NSValue valueWithCATransform3D:CATransform3DScale(originTransform, 1.25, 0.75, 1)],
                                  [NSValue valueWithCATransform3D:CATransform3DScale(originTransform, 0.75, 1.25, 1)],
                                  [NSValue valueWithCATransform3D:CATransform3DScale(originTransform, 1.15, 0.85, 1)],
                                  [NSValue valueWithCATransform3D:CATransform3DScale(originTransform, 0.95, 1.05, 1)],
                                  [NSValue valueWithCATransform3D:CATransform3DScale(originTransform, 1.05, 0.95, 1)],
                                  [NSValue valueWithCATransform3D:CATransform3DScale(originTransform, 1, 1, 1)]
                                  ];
    
    
    _animationGroup.animations = @[transformAnimation];

    
}

@end
