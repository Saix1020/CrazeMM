//
//  GenMobileVcodeCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenMobileVcodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, readonly) NSString* vcode;

@end
