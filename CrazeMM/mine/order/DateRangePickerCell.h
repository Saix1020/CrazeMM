//
//  DateRangePickerCell.h
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"

@protocol DateRangePickerCellDelegate <NSObject>

-(void)startDatePicking:(THDatePickerViewController*)datePicker;

@end

@interface DateRangePickerCell : UITableViewCell<THDatePickerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dateFromField;
@property (weak, nonatomic) IBOutlet UITextField *dateToField;

@property (weak, nonatomic) id<DateRangePickerCellDelegate> delegate;

@end
