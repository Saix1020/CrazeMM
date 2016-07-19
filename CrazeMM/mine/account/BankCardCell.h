//
//  BankCardCell.h
//  CrazeMM
//
//  Created by saix on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "BankCardDTO.h"

@protocol BankCardCellDelegate <NSObject>

-(void)removeButtonClicked:(BankCardDTO*)bankCardDto;

@end


@interface BankCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *cardView;

@property (weak, nonatomic) IBOutlet UILabel *openingBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankAccountLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *defaultCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@property (nonatomic, strong) BankCardDTO* bankCardDto;
@property (nonatomic, weak) id<BankCardCellDelegate> delegate;
@end
