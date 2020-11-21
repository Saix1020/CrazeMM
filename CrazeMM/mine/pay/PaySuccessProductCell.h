//
//  PaySuccessProductCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "M80AttributedLabel.h"
#import "StockDetailDTO.h"
@interface PaySuccessProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *selectCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *unitPriceField;
@property (weak, nonatomic) IBOutlet UILabel *orignalUnitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *seperateNumField;

@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundLabel;

@property (nonatomic, strong) StockDetailDTO* stockDetailDto;

+(CGFloat)cellHeight;

@end
