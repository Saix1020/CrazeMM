//
//  UIPlaceHolderTextView.h
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, strong)  NSString *placeholder;
@property (nonatomic, strong)  UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;



@end
