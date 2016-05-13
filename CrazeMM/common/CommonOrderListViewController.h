//
//  CommonOrderListView.h
//  CrazeMM
//
//  Created by saix on 16/5/8.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentedCell.h"
#import "CommonBottomView.h"
#import "CustomSegment.h"
#import "BEMCheckBox.h"

@interface CommonOrderListViewController : UIViewController<CustomSegmentDelegate, UITableViewDataSource, UITableViewDelegate, BEMCheckBoxDelegate>
{
    @protected
    SegmentedCell* _segmentCell;
    CommonBottomView* _bottomView;
}

@property (nonatomic, strong) SegmentedCell* segmentCell;
@property (nonatomic, strong) CommonBottomView* bottomView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic) CGFloat contentHeightOffset;


@end
