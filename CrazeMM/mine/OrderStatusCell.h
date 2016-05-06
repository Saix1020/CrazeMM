//
//  OrderStatusCell.h
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (nonatomic, copy) NSArray* titleArray;
@end
