//
//  PasswordAlertView.h
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordInputViewDelegate <NSObject>

-(void)DidFinishInput:(NSString*)inputString;
-(void)inputDidChanged:(NSString*)inputString;
@end


@interface PasswordInputView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UITextField *NumFiled1;
@property (weak, nonatomic) IBOutlet UITextField *NumFiled2;
@property (weak, nonatomic) IBOutlet UITextField *NumFiled3;
@property (weak, nonatomic) IBOutlet UITextField *NumFiled4;
@property (weak, nonatomic) IBOutlet UITextField *NumFiled5;
@property (weak, nonatomic) IBOutlet UITextField *NumFiled6;

@property(nonatomic, readonly) NSString* password;
@property (nonatomic, weak) id<PasswordInputViewDelegate> delegate;

-(void)reset;
-(void)resetWithTitile:(NSString*)title;
@end
