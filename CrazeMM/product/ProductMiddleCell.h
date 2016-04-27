//
//  ProductMiddleCell.h
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductMiddleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreDetailButton;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *star2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *checkedImage;

@property (weak, nonatomic) IBOutlet UIImageView *start2;
@property (weak, nonatomic) IBOutlet UIButton *authedButton;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;

+(CGFloat)cellHeight;

@end
