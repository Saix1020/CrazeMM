//
//  AccountDetailCell.h
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

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

+(CGFloat)cellHeight;

@end
