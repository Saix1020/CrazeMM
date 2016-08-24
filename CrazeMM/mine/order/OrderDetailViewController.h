//
//  OrderDetailViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"
#import "OrderDefine.h"

@protocol OrderDetailViewControllerDelegate <NSObject>

-(void)removeOrder:(OrderDetailDTO*)orderDto;
-(void)cancelOrder:(OrderDetailDTO*)orderDto;
-(void)operatorDoneForOrder:(NSArray*)orderDtos;

@end


@interface OrderDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<OrderDetailViewControllerDelegate> delegate;

-(instancetype)initWithOrderStyle:(MMOrderListStyle)style andOrder:(OrderDetailDTO*)orderDto;

@end
