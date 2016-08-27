//
//  PayBottomView.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "M80AttributedLabel.h"
#import "OrderDefine.h"

@interface CommonBottomView : UITableViewCell
@property (weak, nonatomic) IBOutlet BEMCheckBox *selectAllCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *selectAllLabel;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic, readonly) MMOrderType orderType;
@property (nonatomic, readonly) MMOrderSubType orderSubtype;
@property (nonatomic, readonly) MMOrderState orderState;
@property (nonatomic) MMOrderListStyle orderStyle;
@property (weak, nonatomic) IBOutlet UIButton *addtionalButton;

@property (nonatomic) CGFloat totalPrice;

//-(void)setOrderStyle:(MMOrderListStyle)style;

+(CGFloat)cellHeight;

@end
