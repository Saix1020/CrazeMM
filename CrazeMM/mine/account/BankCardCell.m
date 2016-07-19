//
//  BankCardCell.m
//  CrazeMM
//
//  Created by saix on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell

-(void)awakeFromNib
{
    self.cardView.layer.cornerRadius = 4.f;
    self.defaultCheckBox.tintColor = [UIColor whiteColor];
//    self.defaultCheckBox.onFillColor = [UIColor whiteColor];
    self.defaultCheckBox.onTintColor = [UIColor whiteColor];
    self.defaultCheckBox.onCheckColor = [UIColor whiteColor];
    self.defaultCheckBox.animationDuration = 0.f;
    self.defaultCheckBox.boxType = BEMBoxTypeSquare;
    
//    self.defaultCheckBox.userInteractionEnabled = NO;
    
    self.cardView.backgroundColor = [UIColor UIColorFromRGB:0x2391E8];
    [self.removeButton addTarget:self action:@selector(removeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setBankCardDto:(BankCardDTO *)bankCardDto
{
    _bankCardDto = bankCardDto;
    self.openingBankLabel.text = bankCardDto.openingbank;
    self.bankAccountLabel.text = bankCardDto.bankaccount;
    self.bankUserNameLabel.text = bankCardDto.bankusername;
    self.defaultCheckBox.on = bankCardDto.isDefault;
    
    [RACObserve(self, bankCardDto.isDefault) subscribeNext:^(id x){
        self.defaultCheckBox.on = self.bankCardDto.isDefault;
    }];
}

-(void)removeButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(removeButtonClicked:)]) {
        [self.delegate removeButtonClicked:self.bankCardDto];
    }
}

@end
