//
//  UIImage+Utils.m
//  CrazeMM
//
//  Created by saix on 16/5/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)


// 等比缩放
- (UIImage *)hyb_cropEqualScaleImageToSize:(CGSize)size {
    CGFloat scale =  [UIScreen mainScreen].scale;
    
    // 这一行至关重要
    // 不要直接使用UIGraphicsBeginImageContext(size);方法
    // 因为控件的frame与像素是有倍数关系的
    // 比如@1x、@2x、@3x图，因此我们必须要指定scale，否则黄色去不了
    // 因为在5以上，scale为2，6plus scale为3，所生成的图是要合苹果的
    // 规格才能正常
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGSize aspectFitSize = CGSizeZero;
    if (self.size.width != 0 && self.size.height != 0) {
        CGFloat rateWidth = size.width / self.size.width;
        CGFloat rateHeight = size.height / self.size.height;
        
        CGFloat rate = MIN(rateHeight, rateWidth);
        aspectFitSize = CGSizeMake(self.size.width * rate, self.size.height * rate);
    }
    
    [self drawInRect:CGRectMake(0, 0, aspectFitSize.width, aspectFitSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
