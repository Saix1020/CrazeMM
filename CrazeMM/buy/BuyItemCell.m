//
//  BuyItemCell.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyItemCell.h"
#import <objc/runtime.h>

@interface BuyItemCell()

@property (nonatomic, strong) UIImageView* clockView;

@end

@implementation BuyItemCell

-(UIImageView*)clockView
{
    if (!_clockView) {
        _clockView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        _clockView.image = [UIImage imageNamed:@"Clock-1"];

    }
    return _clockView;
}

-(ArrowView*)arrowView
{
    if (!_arrowView) {
        _arrowView = [[ArrowView alloc] init];
        _arrowView.textLabel.text = @"求购";
        _arrowView.frame = CGRectMake(0, 0, 38, 16);
    }
    
    return _arrowView;
}

- (void)awakeFromNib
{
    [self commInit];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commInit];

    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commInit];

    }
    
    return self;
}

-(void)commInit
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //self.arrawView.textLabel.text = @"求购";
    
    //self.titleLabel.text = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    self.detailLabel.text = @"￥1020.00起 10台";
    self.detailLabel.font = [UIFont fontWithName:self.detailLabel.font.fontName size:15.f];
    self.detailLabel.textColor = [UIColor orangeColor];
    [self fomartDetailLabel];

    self.timeLeftLabel.backgroundColor = [UIColor lightGrayColor188];
    self.timeLeftLabel.text = @"10 天 18 小时 20 分钟";
    [self fomartTimeLeftLabel];
    
    self.phoneImageView.image = [UIImage imageNamed:@"prod_placeholder.jpg"];
    self.phoneImageView.layer.borderWidth = 1;
    self.phoneImageView.layer.borderColor = [UIColor lightGrayColor188].CGColor;
    
    self.bottomLine.layer.borderWidth = 0.5;
    self.bottomLine.layer.borderColor = [UIColor lightGrayColor188].CGColor;
    
    
    self.statusLabel.backgroundColor = [UIColor greenTextColor];
    self.statusLabel.text = @"正常";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArrawString:(NSString *)arrawString
{
    self.arrowView.textLabel.text = arrawString;
}

-(NSString*)arrawString
{
    return self.arrowView.textLabel.text;
}

+(CGFloat)cellHeight
{
    return 140.f;
}

-(void)fomartTimeLeftLabel
{
    NSString* timeLeftString = self.timeLeftLabel.text;
    self.timeLeftLabel.text = @"";
    self.timeLeftLabel.textAlignment = kCTTextAlignmentCenter;
    [self.timeLeftLabel appendView:self.clockView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    [self.timeLeftLabel appendText:@" "];
    
    NSArray *colors = @[[UIColor redColor], [UIColor blackColor]];
    NSArray *components = [timeLeftString componentsSeparatedByString:@" "];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index%2]];
        [self.timeLeftLabel appendAttributedText:attributedText];
        [self.timeLeftLabel appendText:@" "];
        index ++;
    }
    
    //self.timeLeftLabel.offsetY = -8.f;

}

-(void)fomartDetailLabel
{
    self.detailLabel.text = @"";
    
    //    self.detailLabel.text = @"￥1020.00起 10台";
    
    UIFont* largFont = [UIFont boldSystemFontOfSize:20];
    UIFont* middleFont = [UIFont systemFontOfSize:14];
    UIFont* smallFont = [UIFont systemFontOfSize:12];
    
    
    NSArray *colors = @[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor blackColor], [UIColor greenTextColor], [UIColor greenTextColor]];
    NSArray *fonts = @[smallFont, largFont, smallFont,
                       smallFont, largFont, middleFont];

    NSArray* components = @[@"￥", @"1020", @".00", @"起  ", @"10", @"台"];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[fonts objectAtIndex:index]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
        [self.detailLabel appendAttributedText:attributedText];
        index ++;
    }
    [self.detailLabel appendView:self.arrowView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // why we need reset backgroud color here?
    self.statusLabel.backgroundColor = [UIColor greenTextColor];


    //self.bottomLine.frame = CGRectMake(8.f, self.bottom, self.width-2*8.f, 1);
}

@end
