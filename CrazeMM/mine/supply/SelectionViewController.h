//
//  SelectionViewController.h
//  CrazeMM
//
//  Created by saix on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectionViewControllerDelegate <NSObject>

-(void)didSelectItemWithTitle:(NSInteger)selectedIndex;

@end


@interface SelectionViewController : UITableViewController

@property (nonatomic, weak) id<SelectionViewControllerDelegate> delegate;

-(instancetype)initWithDataSource:(NSArray*)dataSource andSelectedIndex:(NSInteger)selectedIndex andTitle:(NSString*)title;

@end
