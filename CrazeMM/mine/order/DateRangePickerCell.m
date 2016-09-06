//
//  DateRangePickerCell.m
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "DateRangePickerCell.h"
//#import "UIViewController+KNSemiModal.h"


@interface DateRangePickerCell ()
@property (nonatomic, strong) THDatePickerViewController* dateFromPicker;
@property (nonatomic, strong) THDatePickerViewController* dateToPicker;

@property (nonatomic, strong) NSDate *curDate;

@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;
@property (nonatomic, weak) UITextField* editingTextField;
@end

@implementation DateRangePickerCell

+(NSString*)dateToString:(NSDate*)date
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy/MM/dd"];
    return [inputFormatter stringFromDate:date];
}

+(NSDate*)stringToDate:(NSString*)dateString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy/MM/dd"];
    return [inputFormatter dateFromString:dateString];

}


-(void)awakeFromNib
{
//    self.dateFromField.inputView = nil;
//    self.dateToField.inputView = nil;
    self.dateFromField.delegate = self;
    self.dateToField.delegate = self;
    
    self.dateFromField.placeholder = @"起始日期";
    self.dateToField.placeholder = @"结束日期";
    
    self.dateFromField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.dateFromField.layer.borderWidth = 0.5f;
    self.dateFromField.layer.cornerRadius = 4.f;
    
    self.dateToField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.dateToField.layer.borderWidth = 0.5f;
    self.dateToField.layer.cornerRadius = 4.f;
    
//    [RACObserve(self, fromDate) subscribeNext:^(id x){
//        [self.dateToPicker setDateRangeFrom:self.fromDate toDate:[NSDate distantFuture]];
//    }];
//    
//    [RACObserve(self, toDate) subscribeNext:^(id x){
//        [self.dateFromPicker setDateRangeFrom:[NSDate distantFuture] toDate:self.toDate];
//    }];

}

-(THDatePickerViewController*)dateFromPicker
{
    if (!_dateFromPicker) {
        _dateFromPicker = [THDatePickerViewController datePicker];
        _dateFromPicker.date = [NSDate date];
        _dateFromPicker.delegate = self;
        [_dateFromPicker setAllowSelectionOfSelectedDate:YES];
        [_dateFromPicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
        [_dateFromPicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
        

    }
    
    return _dateFromPicker;
}

-(THDatePickerViewController*)dateToPicker
{
    if (!_dateToPicker) {
        _dateToPicker = [THDatePickerViewController datePicker];
        _dateToPicker.date = [NSDate date];
        _dateToPicker.delegate = self;
        [_dateToPicker setAllowSelectionOfSelectedDate:YES];
        [_dateToPicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
        [_dateToPicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
        
        
    }
    
    return _dateToPicker;
}

-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    self.curDate = datePicker.date;
    
    if (self.editingTextField == self.dateFromField) {
        
        if([self.curDate compare:self.toDate] == NSOrderedDescending ){
            [self.delegate alertWithMessage:@"起始日期必须小于等于结束日期"];
            return ;
        }
        else {
            self.fromDate = self.curDate;
        }
    }
    else {
        if([self.curDate compare:self.fromDate] == NSOrderedAscending ){
            [self.delegate alertWithMessage:@"结束日期必须小于等于起始日期"];
            return ;
        }
        else {
            self.toDate = self.curDate;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(endDatePicking:)]) {
        [self.delegate endDatePicking:datePicker];
    }
    

}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    if (self.editingTextField == self.dateFromField) {
        self.dateFromField.text = [DateRangePickerCell dateToString:self.fromDate];
    }
    else {
        self.dateToField.text = [DateRangePickerCell dateToString:self.toDate];
    }
    
    if ([self.delegate respondsToSelector:@selector(endDatePicking:)]) {
        [self.delegate endDatePicking:datePicker];
    }
}

-(void)datePickerDidHide:(THDatePickerViewController *)datePicker
{
    self.editingTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    if (self.editingTextField == self.dateFromField) {
        self.fromDate = self.curDate;
    }
    else {
        self.toDate = self.curDate;
    }
    
//    if ([self.delegate respondsToSelector:@selector(endDatePicking:)]) {
//        [self.delegate endDatePicking:datePicker];
//    }

}


-(void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate
{
    
    if (self.editingTextField == self.dateFromField) {
        
        if([selectedDate compare:self.toDate] == NSOrderedDescending ){
            [self.delegate alertWithMessage:@"起始日期必须小于等于结束日期"];
            datePicker.date = self.curDate;
            return ;
        }
    }
    else {
        if([selectedDate compare:self.fromDate] == NSOrderedAscending ){
            [self.delegate alertWithMessage:@"结束日期必须小于等于起始日期"];
            datePicker.date = self.curDate;
            return ;
        }
    }

    
    self.curDate = selectedDate;
    
    self.editingTextField.text = [DateRangePickerCell dateToString:selectedDate];
    
    
//    if ([self.delegate respondsToSelector:@selector(endDatePicking:)]) {
//        [self.delegate endDatePicking:self.datePicker];
//    }
//    
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.editingTextField = textField;
    textField.layer.borderColor = [UIColor redColor].CGColor;
    if (textField == self.dateFromField) {
        self.dateFromPicker.date = self.fromDate?self.fromDate:[NSDate date];
        if ([self.delegate respondsToSelector:@selector(startDatePicking:)]) {
            [self.delegate startDatePicking:self.dateFromPicker];
        }
        if (textField.text.length == 0) {
            textField.text = [DateRangePickerCell dateToString:self.dateFromPicker.date];
        }

    }
    else {
        self.dateToPicker.date = self.toDate?self.toDate:[NSDate date];
        if ([self.delegate respondsToSelector:@selector(startDatePicking:)]) {
            [self.delegate startDatePicking:self.dateToPicker];
        }
        if (textField.text.length == 0) {
            textField.text = [DateRangePickerCell dateToString:self.dateToPicker.date];
        }
    }
    

    return NO;
}

-(void)reset
{
    self.editingTextField = nil;
    self.curDate = nil;
    self.fromDate = nil;
    self.toDate = nil;
    
    self.dateFromField.text = nil;
    self.dateToField.text = nil;
}

@end
