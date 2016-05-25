//
//  RotateOutAnimation.m
//  Pods
//
//  Created by titengjiang on 16/2/29.
//
//

#import "RotateOutAnimation.h"

@implementation RotateOutAnimation


-(void)prepare
{
    
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@1,@0];
    
    //transformanimation
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D startTransform = CATransform3DRotate(_targetView.layer.transform, deg(200), 0, 0, 1);
    transformAnimation.values = @[[NSValue valueWithCATransform3D:startTransform],
                                  [NSValue valueWithCATransform3D:_targetView.layer.transform]
                                  ];
    
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
}


@end
