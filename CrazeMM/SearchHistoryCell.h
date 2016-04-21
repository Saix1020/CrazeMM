//
//  SearchHistoryCell.h
//  CrazeMM
//
//  Created by saix on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSeperatorLineCell.h"

@interface SearchHistoryCell : CustomSeperatorLineCell

@property (nonatomic, copy) NSString* historyString;

+(CGFloat)cellHight;

@end
