//
//  BuyItemCell.h
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHArrowView.h"



@interface BuyItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet NHArrowView *arrawView;
@property (weak, nonatomic) UILabel *arrowLable;
@end
