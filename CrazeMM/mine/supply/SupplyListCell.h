//
//  SupplyListCell.h
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "MineSupplyProductDTO.h"
#import "MineStockDTO.h"

typedef NS_ENUM(NSInteger, SupplyListCellStyle){
    kNomalStyle = 0,
    kOffShelfStyle,
    kDealStyle,
    kUnkonwStyle
};

@protocol SupplyListCellDelegate <NSObject>

-(void)buttonClicked:(UIButton*)sender andType:(SupplyListCellStyle)type andSid:(NSInteger)sid;
//-(void)shareButtonClick

@end

@interface SupplyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberLabelTopConstraint;
@property (weak, nonatomic) IBOutlet BEMCheckBox *selectCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UIButton *offButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingContraint;
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
@property (nonatomic) SupplyListCellStyle style;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong) MineSupplyProductDTO* mineSupplyProductDto;

// used for stock
@property (nonatomic, strong) MineStockDTO* mineStockDto;


@property (nonatomic, weak) id<SupplyListCellDelegate> delegate;

+(CGFloat)cellHeight;

@end
