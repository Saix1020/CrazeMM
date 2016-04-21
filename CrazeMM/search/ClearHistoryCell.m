//
//  ClearHistoryCell.m
//  CrazeMM
//
//  Created by saix on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ClearHistoryCell.h"
#import "UIButton+LLBootstrap.h"

#define kCellHight 100.f
#define kButtonWidth 140.f
#define kButtomHight 40.f

@implementation ClearHistoryCell

+(CGFloat)cellHeight
{
    return kCellHight;
}


-(UIButton*)clearHistoryButton
{
    if(!_clearHistoryButton){
        _clearHistoryButton = [[UIButton alloc] init];
        [_clearHistoryButton setTitle:@"清空搜索历史" forState:UIControlStateNormal];
        _clearHistoryButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_clearHistoryButton bs_configureAsDefaultStyle];
        _clearHistoryButton.backgroundColor = [UIColor clearColor];
        [_clearHistoryButton setTitleColor:RGBCOLOR(0, 240, 0) forState:UIControlStateNormal];
        [_clearHistoryButton setTitleColor:RGBCOLOR(131, 131, 131) forState:UIControlStateHighlighted];
        [self.contentView addSubview:_clearHistoryButton];
    }
    
    return _clearHistoryButton;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.clearHistoryButton.frame = CGRectMake((self.bounds.size.width-kButtonWidth)/2,
                                               ([ClearHistoryCell cellHeight]- kButtomHight)/2,
                                               kButtonWidth,
                                               kButtomHight);
    
}

@end
