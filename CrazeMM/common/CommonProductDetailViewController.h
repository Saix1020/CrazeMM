//
//  CommonDetailViewController.h
//  CrazeMM
//
//  Created by saix on 16/9/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDTO.h"
#import "BaseHttpRequest.h"
#import "CommonListCell.h"
#import "OrderLogsCell.h"

@interface CommonProductDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    @protected
    BaseHttpRequest* _detailHttpRequest;
}

@property (nonatomic, strong) BaseHttpRequest* detailHttpRequest;
@property (nonatomic, readonly) NSArray* bottomButtonsTitle;
@property (nonatomic, readonly) UITableView* tableView;
@property (nonatomic, strong) CommonListCell* productDetail;
@property (nonatomic, strong) OrderLogsCell* logsCell;


@property (nonatomic, readonly) NSArray* logDtos;
//@property (nonatomic, readonly) 


@end
