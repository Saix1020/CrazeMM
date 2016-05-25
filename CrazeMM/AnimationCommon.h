//
//  AnimationCommon.h
//  Pods
//
//  Created by titengjiang on 16/3/9.
//
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define deg(x) x*M_PI/180.0f
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height

typedef  void(^AnimationCompleteBlock)(void);


typedef NS_ENUM(NSUInteger, AnimationType) {
    bounce = 0,
    Flash,
    pulse,
    rubberBand,
    shake,
    swing,
    tada,
    wobble,
    jello,
    bounceIn,
    bounceInDown,
    bounceInLeft,
    bounceInRight,
    bounceInUp,
    bounceOut,
    bounceOutDown,
    bounceOutLeft,
    bounceOutRight,
    bounceOutUp,
    fadeIn,
    fadeInDown,
    fadeInDownBig,
    fadeInLeft,
    fadeInLeftBig,
    fadeInRight,
    fadeInRightBig,
    fadeInUp,
    fadeInUpBig,
    fadeOut,
    fadeOutDown,
    fadeOutDownBig,
    fadeOutLeft,
    fadeOutLeftBig,
    fadeOutRight,
    fadeOutRightBig,
    fadeOutUp,
    fadeOutUpBig,
    flip,
    flipInx,
    flipInY,
    flipOutX,
    flipOutY,
    
    lightSpeedIn,
    lightSpeedOut,
    
    RotateIn,
    RotateInDownLeft,
    RotateInDownRight,
    RotateInUpLeft,
    RotateInUpRight,
    
    RotateOut,
    RotateOutDownLeft,
    RotateOutDownRight,
    RotateOutUpLeft,
    RotateOutUpRight,
    
    
    SlideOutUp,
    SlideOutLeft,
    SlideOutRight,
    SlideOutDown,
    
    SlideInUp,
    SlideInLeft,
    SlideInRight,
    SlideInDown,
    
    hinge,
    rollIn,
    rollOut,
    
    zoomIn,
    zoomInDown,
    zoomInLeft,
    zoomInRight,
    zoomInUp,
    
    zoomOut,
    zoomOutDown,
    zoomOutLeft,
    zoomOutRight,
    zoomOutUp,
    
    scaleLargeIn,
    scaleSmallOut
};



