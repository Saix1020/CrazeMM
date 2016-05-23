//
//  SendViewController.h
//  CrazeMM
//
//  Created by saix on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionViewController.h"

@protocol OrderSendViewControllerDelegate <NSObject>

-(void)sendSuccessWithOrderDetailDtos:(NSArray*)orderDetailDtos;

@end

@interface OrderSendViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SelectionViewControllerDelegate>

@property (nonatomic, copy) NSArray* orderDetailDtos;
@property (nonatomic, weak) id<OrderSendViewControllerDelegate> delegate;

-(instancetype)initWithOrderDetaildtos:(NSArray*)orderDetailDtos;


@end
