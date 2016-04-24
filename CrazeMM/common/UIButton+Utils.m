//
//  UIButton+Utils.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIButton+Utils.h"
#import "UIButton+PPiAwesome.h"


@implementation UIButton (Utils)

+(UIButton*)filterButtonAwesome
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom text:@"" icon:@"icon-filter" textAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:[UIColor whiteColor]} andIconPosition:IconPositionRight];
    [button setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:kButtonHightLightColor} forUIControlState:UIControlStateHighlighted];
    [button sizeToFit];
    
    return button;
}

+(UIButton*)arrowUpButtonAwesome
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom text:@"" icon:@"icon-long-arrow-up" textAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:[UIColor whiteColor]} andIconPosition:IconPositionRight];
    [button setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:kButtonHightLightColor} forUIControlState:UIControlStateHighlighted];
    [button sizeToFit];
    
    return button;

}
+(UIButton*)arrowDownButtonAwesome
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom text:@"" icon:@"icon-long-arrow-down" textAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:[UIColor whiteColor]} andIconPosition:IconPositionRight];
    [button setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:kButtonHightLightColor} forUIControlState:UIControlStateHighlighted];
    [button sizeToFit];
    
    return button;

}


-(void)moveImageAbove
{
    CGSize fontSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];

    self.imageEdgeInsets = UIEdgeInsetsMake(-fontSize.height, fontSize.width+self.imageView.bounds.size.width/2, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.bounds.size.width/2, -self.imageView.bounds.size.height, 0);
}

-(void)configureAsDefaultBord
{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    [self setBackgroundColor:[UIColor clearColor]];
}



@end
