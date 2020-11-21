//
//  AvataCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvataCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIImageView *avataImage;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *avaliableLabel;
//@property (weak, nonatomic) IBOutlet UILabel *frozenLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avataImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *frozenLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic) CGFloat frozenMoney;
@property (nonatomic) CGFloat money;

@end
