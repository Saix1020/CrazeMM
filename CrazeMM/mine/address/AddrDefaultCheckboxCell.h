//
//  AddrDefaultCheckboxCell.h
//  CrazeMM
//
//  Created by saix on 16/5/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
@interface AddrDefaultCheckboxCell : UITableViewCell
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox2;

@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@end
