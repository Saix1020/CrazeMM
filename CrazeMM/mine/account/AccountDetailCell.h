//
//  AccountDetailCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AccountDetailCellDelegate <NSObject>

-(void)itemClicked:(NSInteger)type;

@end

@interface AccountDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vLine;
@property (weak, nonatomic) IBOutlet UIView *hLine;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UIButton *withdrawalsButton;

@property (weak, nonatomic) IBOutlet UIButton *mortgageButton;
@property (weak, nonatomic) IBOutlet UIImageView *rechargeImage;

@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UIImageView *mortgageImage;
@property (weak, nonatomic) IBOutlet UIImageView *withdrawlsImage;
@property (weak, nonatomic) IBOutlet UIView *rechargeCell;
@property (weak, nonatomic) IBOutlet UIView *withdrawalsCell;
@property (weak, nonatomic) IBOutlet UIView *cardCell;
@property (weak, nonatomic) IBOutlet UIView *mortgageCell;

@property (weak, nonatomic) id<AccountDetailCellDelegate> delegate;

+(CGFloat)cellHeight;

@end
