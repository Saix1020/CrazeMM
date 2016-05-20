//
//  SelectionViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()


@property (nonatomic, copy) NSArray* dataSource;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, copy) NSString* titleString;
@end

@implementation SelectionViewController

-(instancetype)initWithDataSource:(NSArray*)dataSource andSelectedIndex:(NSInteger)selectedIndex andTitle:(NSString*)title

{
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        self.selectedIndex = selectedIndex;
        self.titleString = title;
    }
    
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleString;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 44.f;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectionCell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.textLabel.text = self.dataSource[indexPath.row];
    if (self.selectedIndex==indexPath.row){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.selectedIndex>=0){
//        if(self.selectedIndex==indexPath.row) {
//            UITableViewCell* selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//            selectedCell.accessoryType = UITableViewCellAccessoryNone;
//            self.selectedIndex = -1;
//        }
//        else {
//            UITableViewCell* selectedCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
//            selectedCell.accessoryType = UITableViewCellAccessoryNone;
//            UITableViewCell* newSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
//            newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
//            self.selectedIndex = indexPath.row;
//
//        }
//    }
//    else {
//        UITableViewCell* selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
//        self.selectedIndex = indexPath.row;
//    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(didSelectItemWithTitle:)]) {
        [self.delegate didSelectItemWithTitle:indexPath.row];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
