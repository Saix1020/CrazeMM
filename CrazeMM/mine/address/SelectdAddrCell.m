//
//  SelectdAddrCell.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SelectdAddrCell.h"
#import "NSMutableAttributedString+M80.h"

@implementation SelectdAddrCell

- (void)awakeFromNib {
    // Initialization code
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.text = @"189买卖王仓库";
    
    self.companyAndPhoneLabel.adjustsFontSizeToFitWidth = YES;
    self.addressLabel.adjustsFontSizeToFitWidth = YES;
    
    self.companyAndPhoneLabel.text = @"南京良晋数码科技有限公司  025-84722229";
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithAttributedString:[[self class] recommandString]];
    [attrString appendAttributedString:[[self class] companyString:@"江苏省南京市玄武区紫东路2号8栋"]];
    self.addressLabel.attributedText = attrString;

}

+(NSAttributedString*)recommandString
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"[推荐寄存]"];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                            range:NSMakeRange(0, [@"[推荐寄存]" length])];
    
    return attributedText;
}

+(NSAttributedString*)companyString:(NSString*)string
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}
                            range:NSMakeRange(0, [string length])];
    
    return attributedText;
}

@end
