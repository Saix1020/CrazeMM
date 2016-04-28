//
//  BasicAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/17.
//  Copyright © 2016年 sloop. All rights reserved.
//
#import "BasicAnimation.h"

@interface BasicAnimation()


@end

@implementation BasicAnimation

- (instancetype)initWith:(AnimationParams *)animationParams
                    view:(UIView *)targetView
{
    self = [super init];
    if (self) {
        _targetView = targetView;
        _params = animationParams;
        _animationGroup = [[CAAnimationGroup alloc] init];
        
    }
    return self;
}

-(void)start{
    [self prepare];
    [self beginAnimation];
}


-(void)prepare
{
    
    
}
-(void)beginAnimation
{
    _animationGroup.delegate= self;
    _animationGroup.duration = _params.duration;
    _animationGroup.repeatCount = _params.repeatCount;
    if(!_params.removedOnCompletion){
        _animationGroup.removedOnCompletion = NO;
        _animationGroup.fillMode = kCAFillModeForwards;
    }
    [_targetView.layer addAnimation:_animationGroup forKey:@""];
    
}

-(void)resume
{
    CGRect oldFrame = _targetView.frame;
    _targetView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _targetView.frame = oldFrame;
    
}

#pragma mark set
-(void)setDelegate:(id)delegate
{
    _delegate =delegate;
    
}

#pragma mark caanimation delegate
- (void)animationDidStart:(CAAnimation *)anim{
    if(_delegate != nil){
        [_delegate animationDidStart:anim];
    }

}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self resume];
    if(_delegate != nil){
        [_delegate animationDidStop:anim finished:flag];
    }
    
    if(_completeBlock !=nil){
        
        _completeBlock();
    }
    
}

@end
