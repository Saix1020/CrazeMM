//
//  AddrRegionCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestViewController.h"

//@protocol ChooseButtonClickedDelegate <NSObject>
//
//-(void)didClicked
//
//@end


@interface AddrRegionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@property (nonatomic, strong) NSString* value;
@property (nonatomic, strong) NSString* title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeadingMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seperatorLineLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seperatorLineHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seperatorLineTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *regionLabelLeading;

-(void)hideChooseButton;

-(void)popSelection:(NSArray*)options andDelegate:(id<SuggestVCDelegate>)delegate;
-(void)dismissSelection;
-(void)setTitleLeadingMarginWithSpace:(CGFloat)space;
-(void)setRegionLabelLeadingWithSpace:(CGFloat)space;
-(void)formartSeperatorLineConstraintsWithlLeading:(CGFloat)leading andHeigt:(CGFloat)height andTrailing:(CGFloat)trailing;
@end


