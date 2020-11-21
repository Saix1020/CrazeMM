//
//  AccountSummaryCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AccountSummaryCell.h"

@implementation AccountSummaryCell

- (void)awakeFromNib {
    // Initialization code
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_alpha"]];
    imageView.contentMode = UIViewContentModeCenter ;
    self.clipsToBounds = YES;

    
    self.backgroundView = imageView;
    
    self.amountMoneyLabel.adjustsFontSizeToFitWidth = YES;
    self.aviliableMoney.adjustsFontSizeToFitWidth = YES;
    self.fronzenMoney.adjustsFontSizeToFitWidth = YES;
    
//    [RACObserve(self, aviliableMoney.text) subscribeNext:^(id x){
//        
//    }];
    self.money = 0;
    self.frozenMoney = 0;
    RACSignal* aviliableMoneySignal = RACObserve(self, money);
    RACSignal* fronzenMoneySignal = RACObserve(self, frozenMoney);
    RACSignal* signal = [RACSignal combineLatest:@[aviliableMoneySignal, fronzenMoneySignal]];
    [signal subscribeNext:^(id x){
        self.amountMoneyLabel.text = [NSString stringWithFormat:@"%.02f", self.money + self.frozenMoney];
    }];
}

+(CGFloat)cellHeight
{
    return 125.f;
}

-(void)setMoney:(CGFloat)money
{
    _money = money;
    self.aviliableMoney.text = [NSString stringWithFormat:@"%.02f元", money];
    
    
}

-(void)setFrozenMoney:(CGFloat)frozenMoney
{
    _frozenMoney = frozenMoney;
    self.fronzenMoney.text = [NSString stringWithFormat:@"%.02f元", _frozenMoney];
    
}


@end
