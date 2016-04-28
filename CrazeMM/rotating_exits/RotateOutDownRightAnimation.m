//
//  RotateOutDownRightAnimation.m
//  Pods
//
//  Created by titengjiang on 16/2/29.
//
//

#import "RotateOutDownRightAnimation.h"

@implementation RotateOutDownRightAnimation


-(void)prepare
{
    
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    
    //change ancpoint
    CGRect oldFrame = _targetView.frame;
    _targetView.layer.anchorPoint = CGPointMake(1, 1);
    _targetView.frame = oldFrame;
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@1,@0];
    
    //transformanimation
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D startTransform = CATransform3DRotate(_targetView.layer.transform, deg(-45), 0, 0, 1);
    transformAnimation.values = @[[NSValue valueWithCATransform3D:_targetView.layer.transform],
                                  [NSValue valueWithCATransform3D:startTransform]
                                  ];
    
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
}
@end
