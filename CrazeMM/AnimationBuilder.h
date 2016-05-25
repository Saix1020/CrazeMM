//
//  AnimationBuilder.h
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/17.
//  Copyright © 2016年 sloop. All rights reserved.
//


#import "AnimationCommon.h"



@interface AnimationBuilder : NSObject


-(AnimationBuilder *)setDuration:(CFTimeInterval)duration;

-(AnimationBuilder *)setAnimationType:(AnimationType)type;

-(AnimationBuilder *)setRepeatCount:(CGFloat )repeatCount;

-(AnimationBuilder *)setRemovedOnCompletion:(BOOL)removedOnCompletion;


-(void)startOn:(UIView * )targetView;

-(void)startOn:(UIView *)targetView
 completeBlock:(AnimationCompleteBlock)completeBlock;



-(AnimationBuilder *)setDelegate:(id)delegate;


@end
