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
    
    self.rechargeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self.rechargeImage addGestureRecognizer:self.rechargeTap];
    [self.mortgageImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)]];
    [self.cardImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)]];
    [self.withdrawlsImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)]];

}

//-(void)dealloc
//{
//    [self.rechargeImage removeGestureRecognizer:self.rechargeTap];
//}

+(CGFloat)cellHeight
{
    return 160.f;
}

-(void)imageTapped:(UIGestureRecognizer*)g
{
    NSLog(@"%@", g.view);
}

@end
