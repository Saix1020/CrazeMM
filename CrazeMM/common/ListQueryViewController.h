//
//  ListQueryViewController.h
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListQueryViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic) NSInteger totalRow;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger pageSize;

@property (nonatomic) BOOL requesting;


-(AnyPromise*)query;
-(CGFloat)cellHeight;
-(UITableViewCell*)listCellWithTabelview:(UITableView*)tableView andIndexPath:(NSIndexPath *)indexPath;

@end
