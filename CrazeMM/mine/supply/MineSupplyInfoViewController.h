//
//  MineSupplyInfoViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonOrderListViewController.h"
@interface MineSupplyInfoViewController : UIViewController
@property (nonatomic, readonly) NSInteger sid;
@property (nonatomic, readonly) NSInteger state;
@property (nonatomic, readonly) BOOL needHideBottomView;
@property (nonatomic, weak) id<ListViewControllerDelegate> delegate;

-(instancetype)initWithId:(NSUInteger)sid andState:(NSInteger)state;
-(void)deplayTimeLine: (NSArray*)logs;


-(void)handleClickEvent:(id)sender;

@end
