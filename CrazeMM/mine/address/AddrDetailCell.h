//
//  AddrDetailCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "AddrDTO.h"

@class  AddrDetailCell;

@protocol AddrDetailCellDelegate <NSObject>

-(void)editButtonClicked:(AddrDetailCell*)cell;
-(void)deleteButtonClicked:(AddrDetailCell*)cell;

@end

@interface AddrDetailCell : UITableViewCell 
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet BEMCheckBox *defaultCheckBox;
@property (strong, nonatomic) IBOutlet UILabel *isDefaultLabel;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

@property (nonatomic) BOOL isDefault;
@property (nonatomic, strong) AddrDTO* addrDto;

@property (nonatomic, weak) id<AddrDetailCellDelegate> delegate;

@end
