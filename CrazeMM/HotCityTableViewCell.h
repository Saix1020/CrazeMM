//
//  HotCityTableViewCell.h
//  Wear
//
//  Created by 孙恺 on 15/11/26.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotCityCellDelegate <NSObject>

- (void)didSelectHotCity:(NSString *)cityName;

@end

@interface HotCityTableViewCell : UITableViewCell

@property (strong, nonatomic) id<HotCityCellDelegate> delegate;
@property (nonatomic, readonly) NSArray* cityWithProvinces;

@end
