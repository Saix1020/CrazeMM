//
//  MMAlertViewWithOK.m
//  CrazeMM
//
//  Created by saix on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MMAlertViewWithOK.h"

@implementation MMAlertViewWithOK
-(void)awakeFromNib
{
    self.alertMsgLabel.adjustsFontSizeToFitWidth = YES;
    self.alertMsgLabel.numberOfLines = 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
