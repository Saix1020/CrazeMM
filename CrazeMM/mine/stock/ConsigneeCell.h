//
//  ConsigneeCell.h
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsigneeDTO.h"

@class ConsigneeCell;

@protocol ConsigneeCellDelegate <NSObject>

-(void)editButtonClicked:(ConsigneeCell*)cell;
-(void)removeButtonClicked:(ConsigneeCell*)cell;

@end



@interface ConsigneeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;


@property (nonatomic, strong) ConsigneeDTO* consigneeDto;
@property (nonatomic, weak) id<ConsigneeCellDelegate> delegate;

+(CGFloat)cellHeight;

@end
