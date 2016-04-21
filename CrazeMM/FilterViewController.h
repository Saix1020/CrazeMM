//
//  FilterViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterVCDelegate <NSObject>

-(void)didChangeFilterKeywords:(NSArray*)keywords;

@end

@interface FilterViewController : UITableViewController

@property (nonatomic, weak) id<FilterVCDelegate> delegate;
@property (nonatomic, copy) NSArray* filterKeywords;

@property (nonatomic) CGFloat height;

@end
