//
//  StockSellCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "M80AttributedLabel.h"
#import "MineStockDTO.h"


@protocol StockSellCellDelegate <NSObject>

-(void)refreshTotalPriceLabel;

@end

@interface StockSellCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *selectCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *unitPriceField;
@property (weak, nonatomic) IBOutlet UILabel *orignalUnitPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton1;
@property (weak, nonatomic) IBOutlet UITextField *totalNumField;

@property (weak, nonatomic) IBOutlet UIButton *subButton1;
@property (weak, nonatomic) IBOutlet UIButton *addButton2;
@property (weak, nonatomic) IBOutlet UITextField *seperateNumField;

@property (weak, nonatomic) IBOutlet UIButton *subButton2;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundLabel;

@property (nonatomic) NSInteger totalCountNum;

@property (nonatomic) NSInteger earning;

@property (nonatomic, strong) MineStockDTO* stockDto;
@property (nonatomic, strong) StockDetailDTO* stockDetailDto;

@property (nonatomic, weak) id<StockSellCellDelegate> delegate;

+(CGFloat)cellHeight;
@end
