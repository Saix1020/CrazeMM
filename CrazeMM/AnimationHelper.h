//
//  AnimationHelper.h
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/21.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "BasicAnimation.h"
#import "AnimationBuilder.h"

@interface AnimationHelper : BasicAnimation


+(void)playAnimationOn:(UIView *)targetView
         animationType:(AnimationType)animationType;


+(void)playAnimationOn:(UIView *)targetView
         animationType:(AnimationType)animationType
              delegate:(id)delegate;
@end
