//
//  ClearHistoryCell.h
//  CrazeMM
//
//  Created by saix on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClearHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (nonatomic, strong) UIButton* clearHistoryButton;

+(CGFloat)cellHeight;

@end
