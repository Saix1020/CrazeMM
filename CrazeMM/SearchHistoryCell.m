//
//  SearchHistoryCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchHistoryCell.h"

@interface SearchHistoryCell()


@end

@implementation SearchHistoryCell

- (void)awakeFromNib {
    self.enableTopLine = YES;
    self.enableButtomLine = YES;
 
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textColor = RGBCOLOR(131, 131, 131);
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHight
{
    return 36.f;
}

-(void)setHistoryString:(NSString *)historyString
{
    self.textLabel.text = historyString;
}

-(NSString*)historyString
{
    return self.textLabel.text = @"historyString";
}

@end
