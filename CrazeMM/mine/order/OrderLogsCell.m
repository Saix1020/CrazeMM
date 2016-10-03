//
//  OrderLogsCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderLogsCell.h"
#import "OrderStatusDTO.h"

@interface OrderLogsCell()

@property (nonatomic, strong) TimeLineViewControl *timeline;
@property (nonatomic, strong) UIView* timelineBGView;
@end



@implementation OrderLogsCell

-(UIView*)timelineBGView
{
    if (!_timelineBGView){
        _timelineBGView = [[UIView alloc] init];
        [self.contentView addSubview:_timelineBGView];
    }
    return _timelineBGView;
}

- (void)awakeFromNib {
    // Initialization code
//    NSArray *times = @[@"",@"",@"",@"",@"",@"",@""];
//    NSArray *descriptions = @[@"state 1",@"state 2",@"state 3",@"state 4",@"very very long and very very \ndetailed description 0f state 5",@"state 6",@"state 7"];
//    self.timeline = [[TimeLineViewControl alloc] initWithTimeArray:times
//                                                           andTimeDescriptionArray:descriptions
//                                                                  andCurrentStatus:4
//                                                                          andFrame:CGRectMake(0.f, 16.f, [UIScreen mainScreen].bounds.size.width-32.f, 160.f)];
//    [self.contentView addSubview:self.timeline];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLogs:(NSArray *)logs
{
    _logs = [logs sortedArrayUsingComparator:^NSComparisonResult(OrderLogDTO* obj1, OrderLogDTO* obj2){
        return [obj2.createTime localizedCompare:obj1.createTime];
    }];
    
    [self.timeline removeFromSuperview];
    
    NSMutableArray* timesPlacehoderArray = [[NSMutableArray alloc] init];
    NSMutableArray* commentsArray = [[NSMutableArray alloc] init];
    
    for (OrderLogDTO* logDto in _logs) {
        [timesPlacehoderArray addObject:@""];
        [commentsArray addObject:logDto.description];
    }
    
    self.timeline = [[TimeLineViewControl alloc] initWithTimeArray:timesPlacehoderArray
                                           andTimeDescriptionArray:commentsArray
                                                  andCurrentStatus:1
                                                          andFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width+20 , 0)];
    [self.contentView addSubview:self.timeline];
    [self.timeline sizeToFit];

}

-(CGFloat)cellHeight
{
    CGFloat timelineHeight = MAX(self.timeline.timeLabelsHeight, self.timeline.descLabelsHeight);
    
    if (timelineHeight < 90.f) {
        return 90.f+60.f;
    }
    return timelineHeight + 16.f + 60.f;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.timeline.x = -48.f;
    self.timeline.y = 8.f+20.f;
    self.timeline.height = self.height - 16.f;
    self.timeline.width = self.contentView.width + 48.f;
}

@end
