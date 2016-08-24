//
//  CATransform3DExtend.c
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CATransform3DExtend.h"


CATransform3D CATransform3DMakeSkew (CGFloat angleX, CGFloat angleY)
{
    
    CGAffineTransform affineTransform  = CGAffineTransformMake(1, tanf(angleX*M_PI/180.0f), tanf(angleY*M_PI/180.0f), 1, 0, 0);
    
    return  CATransform3DMakeAffineTransform(affineTransform);
}

CATransform3D CATransform3DSkew (CATransform3D t,CGFloat angleX, CGFloat angleY)
{
    
    CGAffineTransform affineTransform  = CGAffineTransformMake(1, tanf(-angleX*M_PI/180.0f), tanf(-angleY*M_PI/180.0f), 1, 0, 0);
    CATransform3D skewTransform = CATransform3DMakeAffineTransform(affineTransform);
    
    return CATransform3DConcat(t, skewTransform);
    
}

CATransform3D CATransform3DSkewX(CATransform3D t,CGFloat angleX)
{
    
    t.m21 = tanf(-angleX*M_PI/180.0f);
    return t;
}

CATransform3D CATransform3DPerspective (CATransform3D t,CGFloat distance)
{
    
    CATransform3D distanceTransform3D =  t;
    if(distance != 0){
        
        distanceTransform3D.m34 = 1.0f/distance;
    }
    
    
    return distanceTransform3D;
    
}