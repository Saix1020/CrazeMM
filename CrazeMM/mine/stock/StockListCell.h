//
//  StockListCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "MineStockDTO.h"

@protocol StockListCellDelegate <NSObject>

-(void)buttonClicked:(UIButton*)sender andSid:(NSInteger)sid;

-(void)pickupButtonClicked:(UIButton*)sender andSid:(NSInteger)sid;
-(void)sellButtonClicked:(UIButton*)sender andSid:(NSInteger)sid;


@end

@interface StockListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceContraint;
@property (weak, nonatomic) IBOutlet BEMCheckBox *selectCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIButton *offButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
@property (weak, nonatomic) IBOutlet UIButton *pickupButton;

@property (weak, nonatomic) id<StockListCellDelegate> delegate;

@property (nonatomic, strong) MineStockDTO* mineStockDto;

@property (nonatomic) BOOL hiddenButtons;
@property (nonatomic) BOOL hiddenCheckBox;

+(CGFloat)cellHeight;

@end
