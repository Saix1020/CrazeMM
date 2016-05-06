//
//  NSString+Utils.h
//  CrazeMM
//
//  Created by saix on 16/5/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

-(CGSize)boundingRectWithFont:(UIFont*)font andWidth:(CGFloat)width;
-(CGSize)boundingWidthWithFont:(UIFont*)font;

-(UIImage*)image;

+(NSString*)leftTimeString:(NSUInteger)millisecond;

@end
