//
//  MineSupplyEditViewController.h
//  CrazeMM
//
//  Created by saix on 16/5/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "SelectionViewController.h"

@protocol MineSupplyEditViewControllerDelegate <NSObject>

-(void)editSupplyGoodSuccess;

@end

@interface MineSupplyEditViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, BEMCheckBoxDelegate, SelectionViewControllerDelegate>

@property (nonatomic, weak) id<MineSupplyEditViewControllerDelegate> delegate;

@end
