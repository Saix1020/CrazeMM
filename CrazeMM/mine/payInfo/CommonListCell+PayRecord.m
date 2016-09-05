//
//  CommonListCell+PayRecord.m
//  CrazeMM
//
//  Created by Mao Mao on 16/8/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonListCell+PayRecord.h"
#import "PayRecordDTO.h"

@implementation CommonListCell (PayRecord)

-(PayRecordDTO*) payRecordDto
{
    return (PayRecordDTO*)self.dto;
}

-(void) setPayRecordDTO:(PayRecordDTO *)dto
{
    [self formatPayOrderLabel:dto.payNo];
    [self formatPayStatusLabel:dto.state];
    [self formatPaySubmitTime:dto.createTime];
    [self formatPayOrderIds:dto.orderIds];
    [self formatPayPrice:dto.total];
    [self formatDetailedInfo:dto.msg];
    
    [self formatButton:dto.state];
    
}

-(void)formatPayOrderLabel:(NSInteger)orderId
{
    self.orderLabel.text = [NSString stringWithFormat:@"支付单号: P%ld", orderId];
}

-(void)formatPayStatusLabel:(NSInteger)state
{
    NSString* strState =[[NSString alloc]init];
    //支付中、支付成功、支付失败
    switch (state) {
        case 100:
            strState = @"支付中";
            break;
        case 200:
            strState = @"支付成功";
            break;
        case 300:
            strState = @"支付失败";
            break;
            
        default:
            strState = @"支付中";
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@" %@ ", strState];
    
}

-(void)formatPaySubmitTime:(NSString*)createTime
{
    self.titleLabel.text = [NSString stringWithFormat:@"提交时间: %@ ", createTime];
}

-(void)formatPayOrderIds:(NSString*)orderIds
{
    self.firstLabel.text = [NSString stringWithFormat:@"涉及订单: %@ ", orderIds];
}

-(void)formatPayPrice:(NSString*)total
{
    NSString* firstComponent = [NSString stringWithFormat:@"支付金额: "];
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString: firstComponent
                                           attributes:@{
                                                        NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                                        }];
    
    NSString* secondComopent = [NSString stringWithFormat:@"￥%@", total];
    [attributedText appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:secondComopent attributes:@{
                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:13.f],
                                                                                       NSForegroundColorAttributeName: [UIColor redColor]                                             }]];
    
    self.secondLabel.attributedText = attributedText;

}

-(void)formatDetailedInfo:(NSString*)msg
{
    self.thirdLabel.text = [NSString stringWithFormat:@"详细信息: %@ ", msg];
}

-(void)formatButton:(NSInteger)state
{
    switch (state) {
        case 100:
            [self.rightButton setTitle:@"删除" forState:UIControlStateNormal];
            break;
        case 200:
            [self.rightButton setTitle:@"撤销" forState:UIControlStateNormal];
            break;
        case 300:
            [self.rightButton setTitle:@"还款" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
    


@end
