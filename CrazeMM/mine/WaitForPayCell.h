//
//  WaitForPayCell.h
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "M80AttributedLabel.h"


@interface WaitForPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet BEMCheckBox *selectedCheckBox;
@property (weak, nonatomic) IBOutlet UIImageView *companyIcon;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *companyWithIconLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *productDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *totalPriceLabel;

@property (weak, nonatomic) IBOutlet UIView *backgroundLabel;

+(CGFloat)cellHeight;

@end
