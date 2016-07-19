//
//  LastPayMethodCell.h
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastPayMethodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *accessoryButton;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (nonatomic) NSString* payWay;

+(CGFloat)cellHeight;
@end
