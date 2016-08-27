//
//  SwitchCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *swith;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@end
