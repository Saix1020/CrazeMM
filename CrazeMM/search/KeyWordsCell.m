//
//  KeyWordsCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "KeyWordsCell.h"


#define kButtonSpacehoderSpace 10.f
#define kButtonHeight 30.f
#define kButtonLineHeight 45.f




@interface KeyWordsCell()

@property (nonatomic, strong) NSMutableArray* buttonArray;
@property (nonatomic) CGFloat cellHight;

//@property (nonatomic) CGFloat


@end


@implementation KeyWordsCell

- (void)awakeFromNib {
    self.enableTopLine = YES;
    self.enableButtomLine = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setKeywords:(NSArray *)keywords
{
    _keywords = [keywords copy];
    
    for(UIView* subView in self.contentView.subviews){
        [subView removeFromSuperview];
    }
    
    self.buttonArray = [[NSMutableArray alloc] init];
    
    self.topSeperatorLine = nil;
    self.buttomSeperatorLine = nil;
    
    int x = kHeadAlign, y = kTopAlign;
    for (int i = 0; i < _keywords.count; i++)
    {
        NSString *str = [_keywords objectAtIndex:i];
        UIButton *btn = [[UIButton alloc] init];
        CGSize sz = [str sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}];
        CGFloat width = sz.width + kButtonSpacehoderSpace;
        if (x + sz.width + kButtonSpacehoderSpace > [UIScreen mainScreen].bounds.size.width-kTailAlign) {
//            width = [UIScreen mainScreen].bounds.size.width- kTailAlign - x;
            x = kHeadAlign;
            y += kButtonHeight + kTopAlign;
        }
        btn.frame = CGRectMake(x, y, width, kButtonHeight);
        
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:RGBCOLOR(131, 131, 131) forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor light_Gray_Color].CGColor;//RGBCOLOR(235, 235, 235).CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 4;
        [btn setTitle:str forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.tag = i + 1;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:btn];
        [self.buttonArray addObject:btn];
        
        x += (width +10);
        if (x >= [UIScreen mainScreen].bounds.size.width - kTailAlign && i!=_keywords.count-1)
        {
            x = kHeadAlign;
            y += kButtonHeight + kTopAlign;
        }
    }
    _cellHight = y + kButtonHeight + kTopAlign;
}

-(void)setKeywords:(NSArray *)keywords andBlock:(signalBlock)block
{
    self.keywords = keywords;
    if (block) {
        for (UIButton* button in self.buttonArray) {
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                if(block) {
                    block(input);
                }
                return [RACSignal empty];
            }];

        }
    }
}

-(CGFloat)cellHight
{
    return ceil(_cellHight);
}



@end
