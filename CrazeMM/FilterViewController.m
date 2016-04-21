//
//  FilterViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "FilterViewController.h"

@implementation FilterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footView;
    
    UIView *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    headView.backgroundColor = RGBCOLOR(150, 150, 150);
    self.tableView.tableHeaderView = headView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
}

-(CGFloat)height
{
    return self.filterKeywords.count * 40.f + 30.f;
}


#pragma -- mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell* cell = [[[NSBundle mainBundle]loadNibNamed:@"BuyItemCell" owner:nil options:nil] firstObject];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FilterKeywordsCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterKeywordsCell"];
    }
    
    cell.textLabel.text = self.filterKeywords[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filterKeywords.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.accessoryType != UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didChangeFilterKeywords:)]){
        [self.delegate performSelector:@selector(didChangeFilterKeywords:) withObject:self.filterKeywords];
    }
}

@end
