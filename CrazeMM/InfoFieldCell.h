//
//  InfoFieldCell.h
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeoutButton.h"

@interface InfoFieldCell : UITableViewCell<TimeoutButtonDelegate>

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UITextField* infoField;
@property (nonatomic, strong) TimeoutButton* button;
@property (nonatomic, strong) UIView* seperatorLine;

@property (nonatomic) CGFloat titleWidth;
@property (nonatomic) BOOL needButton;

@property (nonatomic) NSString* value;


-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
