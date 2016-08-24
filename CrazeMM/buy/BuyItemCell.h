//
//  BuyItemCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrowView.h"
#import "M80AttributedLabel.h"
#import "ProductDescriptionDTO.h"


@interface BuyItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (copy, nonatomic) NSString* arrawString;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *detailLabel;

@property (strong, nonatomic) ArrowView* arrowView;

@property (strong, nonatomic) ProductDescriptionDTO* productDescDTO;

@property (weak, nonatomic) RACSignal* timeSignal;


+(CGFloat)cellHeight;
@end
