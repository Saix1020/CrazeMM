//
//  MMAlertView.h
//  CrazeMM
//
//  Created by saix on 16/4/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MMAlertViewWithOKAndCancel : UIView
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *AlertMsgLabel;
@end
