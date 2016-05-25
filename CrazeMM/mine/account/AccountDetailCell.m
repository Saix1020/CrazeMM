//
//  AccountDetailCell.m
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AccountDetailCell.h"

@interface AccountDetailCell ()

@property (nonatomic, strong) UITapGestureRecognizer* rechargeTap;

@end



@implementation AccountDetailCell

- (void)awakeFromNib {
    // Initialization code
    
    self.vLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.hLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.rechargeImage.userInteractionEnabled = YES;
    self.mortgageImage.userInteractionEnabled = YES;
    self.cardImage.userInteractionEnabled = YES;
    self.withdrawlsImage.userInteractionEnabled = YES;
    
    self.rechargeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)];
    [self.rechargeCell addGestureRecognizer:self.rechargeTap];
    [self.mortgageCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)]];
    [self.cardCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)]];
    [self.withdrawalsCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)]];

    [self.rechargeButton addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mortgageButton addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardButton addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.withdrawalsButton addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];

}

//-(void)dealloc
//{
//    [self.rechargeImage removeGestureRecognizer:self.rechargeTap];
//}

+(CGFloat)cellHeight
{
    return 160.f;
}

-(void)itemClicked:(UIGestureRecognizer*)sender
{
    NSInteger type = 0;
    if ([sender isKindOfClass:[UIGestureRecognizer class]]) {
        UIGestureRecognizer* g = (UIGestureRecognizer*)sender;
        NSLog(@"%@", g.view);
        if (g.view == self.rechargeCell) {
            type = 0;
        }
        else if(g.view == self.mortgageCell) {
            type = 1;
        }
        else if(g.view == self.cardCell){
            type = 2;
        }
        else {
            type = 3;
        }
    }
    else if([sender isKindOfClass:[UIButton class]]){
        UIButton* b = (UIButton*)sender;
        NSLog(@"%@", b);
        if (b == self.rechargeButton) {
            type = 0;
        }
        else if(b == self.mortgageButton) {
            type = 1;
        }
        else if(b == self.cardButton){
            type = 2;
        }
        else {
            type = 3;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(itemClicked:)]) {
        [self.delegate itemClicked:type];
    }
}

@end
