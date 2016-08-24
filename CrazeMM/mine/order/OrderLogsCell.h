//
//  OrderLogsCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineViewControl.h"

@interface OrderLogsCell : UITableViewCell

@property (nonatomic, copy) NSArray* logs;
-(CGFloat)cellHeight;

@end
