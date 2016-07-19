//
//  WithDrawAlertView.h
//  CrazeMM
//
//  Created by saix on 16/6/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WithDrawAlertViewDelegate <NSObject>

-(void)DidFinishInput:(NSString*)inputString;
-(void)dismiss;
@end


@interface WithDrawAlertView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstNumField;
@property (weak, nonatomic) IBOutlet UITextField *secondNumField;
@property (weak, nonatomic) IBOutlet UITextField *thirdNumField;
@property (weak, nonatomic) IBOutlet UITextField *fourthNumField;
@property (weak, nonatomic) IBOutlet UITextField *fifthNumField;
@property (weak, nonatomic) IBOutlet UITextField *sixthNumField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic) float amount;
@property (nonatomic, readonly) NSString* password;

@property (nonatomic, weak) id<WithDrawAlertViewDelegate> delegate;

@end
