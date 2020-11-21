//
//  AllOrderListFilterViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AllOrderListFilterViewController.h"
#import "FilterTagsCell.h"
#import "OrderDefine.h"

@interface AllOrderListFilterViewController ()

@property (nonatomic, strong) FilterTagsCell* statesCell;
@property (nonatomic, strong) UITableViewCell* wrappedStatesCell;
@property (nonatomic, strong) UITableViewCell* statesLabelCell;
@property (nonatomic, strong) NSMutableArray* myCellArray;
@end

@implementation AllOrderListFilterViewController

-(FilterTagsCell*)statesCell
{
    if (!_statesCell) {
        _statesCell = [[FilterTagsCell alloc] init];
        _statesCell.delegate = self;
    }
    
    return _statesCell;
}

-(UITableViewCell*)wrappedStatesCell
{
    if (!_wrappedStatesCell) {
        _wrappedStatesCell = [[UITableViewCell alloc] init];
        [_wrappedStatesCell addSubview:self.statesCell];
        self.statesCell.x = 0.f;
        self.statesCell.filterTags = [OrderDefine allOrderState];
        //self.statesCell.frame = CGRectMake(8.f, 0, self.statesCell.height, )
        _wrappedStatesCell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return _wrappedStatesCell;
}

-(UITableViewCell*)statesLabelCell
{
    if (!_statesLabelCell) {
        _statesLabelCell = [[UITableViewCell alloc] init];
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 2.f, 180, 26.f)];
        nameLabel.font = [UIFont smallFont];
        nameLabel.text = @"订单状态";
        [_statesLabelCell.contentView addSubview:nameLabel];
        _statesLabelCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _statesLabelCell;
}

-(NSArray*)cellArray
{
    return self.myCellArray;
}

-(void)loadView
{
    [super loadView];
    self.myCellArray = [[super cellArray] mutableCopy];
    [self.myCellArray addObject:self.statesLabelCell];
    [self.myCellArray addObject:self.wrappedStatesCell];

}

-(void)didTaped:(id)sender
{
    [self.view endEditing:YES];
}

-(NSDictionary*)conditions
{
    NSMutableDictionary *conditions = [[super conditions] mutableCopy];
    NSMutableArray* status = [[NSMutableArray alloc] init];
    [self.statesCell.selectedTags enumerateObjectsUsingBlock:^(NSString* stateString, NSUInteger idx, BOOL *stop){
        [status addObject:[OrderDefine allOrderStateMap][stateString]];
    }];
    if (status.count == 0){
        status[0] = @"all";
    }
    conditions[@"state"] = [status componentsJoinedByString:@","];
    
    return conditions;
}


-(void)resetSearchCond
{
    [super resetSearchCond];
    [self.statesCell reset];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.cellArray.count-1) {
        return self.statesCell.height;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)datePickingViewDidAppeared
{
//    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height+100);
//    [self.tableView setContentOffset:CGPointMake(0, 100) animated:YES];

}

-(void)datePickingViewDidDisappeared
{
//    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height-100);
}


@end
