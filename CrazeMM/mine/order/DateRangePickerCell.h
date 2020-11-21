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
-(void)endDatePicking:(THDatePickerViewController*)datePicker;
-(void)alertWithMessage:(NSString*)message;
@end

@interface DateRangePickerCell : UITableViewCell<THDatePickerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dateFromField;
@property (weak, nonatomic) IBOutlet UITextField *dateToField;

@property (weak, nonatomic) id<DateRangePickerCellDelegate> delegate;

@property (readonly, nonatomic) NSDate* fromDate;
@property (readonly, nonatomic) NSDate* toDate;

-(void)reset;

@end
