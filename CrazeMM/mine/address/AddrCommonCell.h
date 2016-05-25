//
//  AddrCommonCell.h
//  CrazeMM
//
//  Created by saix on 16/5/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddrCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCell;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* value;
@property (nonatomic, strong) NSString* placehoder;

@end
