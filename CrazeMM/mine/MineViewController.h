//
//  MineViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"
#import "OrderStatusCell.h"

typedef NS_ENUM(NSInteger, MineTableViewSection){
    kSectionOverview = 0,
    kSectionInfo,
    kSectionContact,
    kSectionLogout,
    kSectionMax
};


@interface MineViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CustomSegmentDelegate, OrderStatusCellDelegate>

@property (nonatomic, strong) UITableView* tableView;


@end
