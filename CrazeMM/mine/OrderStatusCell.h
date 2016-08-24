//
//  OrderStatusCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderStatusCellDelegate <NSObject>

-(void)orderStatusCellButtonClicked:(UIButton*)button andButtonIndex:(NSUInteger)index;

@end

@interface OrderStatusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (nonatomic, copy) NSArray* titleArray;

@property (nonatomic, weak) id<OrderStatusCellDelegate> delegate;
@end
