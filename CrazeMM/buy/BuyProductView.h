//
//  BuyProductView.h
//  CrazeMM
//
//  Created by saix on 16/4/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M80AttributedLabel.h"
#import "BaseProductDetailDTO.h"

@protocol BuyProductViewDelegate <NSObject>

-(void)handleButtonClicked:(UIButton*)button;

@end

@interface BuyProductView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *amountPrice;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UIButton *determineButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) BaseProductDetailDTO* productDetailDto;

@property (nonatomic, assign) double price;

@property (nonatomic, weak) id<BuyProductViewDelegate> deleage;

@end
