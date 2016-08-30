//
//  DateRangePickerCell.m
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "DateRangePickerCell.h"
#import "UIViewController+KNSemiModal.h"


@interface DateRangePickerCell ()
@property (nonatomic, strong) THDatePickerViewController* datePicker;
@property (nonatomic, strong) NSDate *curDate;
@end

@implementation DateRangePickerCell

-(void)awakeFromNib
{
    self.dateFromField.inputView = nil;
    self.dateToField.inputView = nil;
    self.dateFromField.delegate = self;
    self.dateToField.delegate = self;
}

-(THDatePickerViewController*)datePicker
{
    if (!_datePicker) {
        _datePicker = [THDatePickerViewController datePicker];
        _datePicker.date = [NSDate date];
        self.datePicker.delegate = self;
        [self.datePicker setAllowClearDate:NO];
        [self.datePicker setClearAsToday:YES];
        [self.datePicker setAutoCloseOnSelectDate:YES];
        [self.datePicker setAllowSelectionOfSelectedDate:YES];
        [self.datePicker setDisableHistorySelection:YES];
        [self.datePicker setDisableFutureSelection:NO];
        [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
        [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
        

    }
    
    return _datePicker;
}

-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    self.curDate = datePicker.date;
}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    
}



-(void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate
{
    self.curDate = datePicker.date;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(startDatePicking:)]) {
        [self.delegate startDatePicking:self.datePicker];
    }

    return NO;
}

@end
