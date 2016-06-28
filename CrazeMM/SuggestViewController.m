//
//  SuggestViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController()

//@property (nonatomic, strong) 

@end

@implementation SuggestViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor clearColor];
    
//    UIView *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
//    headView.backgroundColor = RGBCOLOR(150, 150, 150);
//    self.tableView.tableHeaderView = headView;
//    
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
}

-(CGFloat)height
{
    return self.suggestedStrings.count * 40.f ;
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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestStringCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SuggestStringCell"];
    }
    
    cell.textLabel.text = self.suggestedStrings[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.suggestedStrings.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectSuggestString:)]){
        [self.delegate performSelector:@selector(didSelectSuggestString:) withObject:cell.textLabel.text];
    }
}

-(void)dealloc
{
    NSLog(@"dealloc %@", self.class);
}


@end
