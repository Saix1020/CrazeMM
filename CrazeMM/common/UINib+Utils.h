//
//  UINib+Utils.h
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (Utils)

+(UIView*)viewFromNib:(NSString*)nibName;

+(UIView*)viewFromNibByClass:(id)class;

@end
