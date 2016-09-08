//
//  CommonListCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"


@class CommonListCell;

@protocol CommonListCellDelegate <NSObject>

-(void)didSelectedListCell:(CommonListCell*)cell;
-(void)leftButtonClicked:(CommonListCell*)cell;
-(void)rightButtonClicked:(CommonListCell*)cell;
-(void)topButtonClicked:(CommonListCell *)cell;

@end

@interface CommonListCell : UITableViewCell<BEMCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel2;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionalLabelTwo;

@property (weak, nonatomic) IBOutlet UILabel *additionalLabelOne;
@property (strong, nonatomic) BaseListDTO* dto;
@property (nonatomic) BOOL on;

@property (weak, nonatomic) id<CommonListCellDelegate> delegate;

-(void)formatOrderLabel:(NSInteger)orderId;
-(void)formatTimeLabel:(NSString*)timeString;
-(void)formatStatusLabel:(NSString*)status;
-(void)formatGoodNameLabel:(NSString*)goodName;

+(CGFloat)cellHeight;

@end
