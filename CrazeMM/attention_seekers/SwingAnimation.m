//
//  SwingAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "SwingAnimation.h"

@implementation SwingAnimation

-(void)prepare
{
    
    CGRect oldFrame = _targetView.frame;
    _targetView.layer.anchorPoint = CGPointMake(0.5, 0);
    _targetView.frame = oldFrame;
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.2,@0.4,@0.6,@0.8,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D originTransform = _targetView.layer.transform;
    NSValue * beginValue = [NSValue valueWithCATransform3D:originTransform];
    NSValue * firstRotateValue = [NSValue valueWithCATransform3D:CATransform3DRotate(originTransform, 15 * M_PI/180, 0, 0, 1)];
    NSValue * secondRotateValue = [NSValue valueWithCATransform3D:CATransform3DRotate(originTransform, -10* M_PI/180, 0, 0, 1)];
    NSValue * thirdRotateValue = [NSValue valueWithCATransform3D:CATransform3DRotate(originTransform, 5* M_PI/180, 0, 0, 1)];
    NSValue * fouthRotateValue = [NSValue valueWithCATransform3D:CATransform3DRotate(originTransform, -5* M_PI/180, 0, 0, 1)];
    NSValue * lastRotateValue =[NSValue valueWithCATransform3D:CATransform3DRotate(originTransform, 0, 0, 0, 1)];
    
    
    transformAnimation.values = @[beginValue,
                                  firstRotateValue,
                                  secondRotateValue,
                                  thirdRotateValue,
                                  fouthRotateValue,
                                  lastRotateValue
                                  
                                  ];
    
    _animationGroup.animations = @[transformAnimation];

    

}



@end
