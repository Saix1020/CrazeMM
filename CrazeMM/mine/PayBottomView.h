//
//  PayBottomView.h
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "M80AttributedLabel.h"
@interface PayBottomView : UITableViewCell
@property (weak, nonatomic) IBOutlet BEMCheckBox *selectAllCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *selectAllLabel;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

+(CGFloat)cellHeight;

@end
