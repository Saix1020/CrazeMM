//
//  CustomSeperatorLineCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHeadAlign 16.f
#define kTopAlign 16.f
#define kTailAlign 16.f
#define kButtomAlign 16.f

@interface CustomSeperatorLineCell : UITableViewCell

@property (nonatomic, strong) UIView* topSeperatorLine;
@property (nonatomic, strong) UIView* buttomSeperatorLine;

@property (nonatomic) BOOL enableTopLine;
@property (nonatomic) BOOL enableButtomLine;


@end
