//
//  CommonListCell.m
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//



#import "CommonListCell.h"

@interface CommonListCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderLabelLeadingContraint;

@end

@implementation CommonListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.checkBox.onCheckColor = [UIColor whiteColor];
    self.checkBox.onTintColor = [UIColor redColor];
    self.checkBox.onFillColor = [UIColor redColor];
    self.checkBox.boxType = BEMBoxTypeCircle;
    self.checkBox.on = NO  ;
    self.checkBox.animationDuration = 0.f;
    self.checkBox.delegate = self;
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.seperatorLine.backgroundColor  = [UIColor light_Gray_Color];
    
    self.leftButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    self.rightButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    [self.leftButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    self.bottomView.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    
    self.statusLabel.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];//
    self.statusLabel.layer.cornerRadius = 4.f;
    self.statusLabel.clipsToBounds = YES;
    self.statusLabel.textColor = [UIColor UIColorFromRGB:0x3972a2];
    
    [RACObserve(self.checkBox, hidden) subscribeNext:^(id x){
        if (self.checkBox.hidden) {
            self.orderLabelLeadingContraint.constant = 0;
        }
        else {
            self.orderLabelLeadingContraint.constant = 24.f;
        }
        
        [self updateConstraintsIfNeeded];
    }];
    
}

//-(BOOL)on
//{
//    return self.checkBox.on;
//}

-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    self.dto.selected = checkBox.on;
    if ([self.delegate respondsToSelector:@selector(didSelectedListCell:)]) {
        [self.delegate didSelectedListCell:self];
    }
}

-(void)buttonClicked:(UIButton*)button
{
    if (button == self.leftButton) {
        if ([self.delegate respondsToSelector:@selector(leftButtonClicked:)]) {
            [self.delegate leftButtonClicked:self];
        }
    }
    else if (button == self.rightButton) {
        if ([self.delegate respondsToSelector:@selector(rightButtonClicked:)]) {
            [self.delegate rightButtonClicked:self];
        }
    }
}

+(CGFloat)cellHeight
{
    return 180.f;
}

@end
