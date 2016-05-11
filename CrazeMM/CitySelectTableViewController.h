//
//  CitySelectTableViewController.h
//  Wear
//
//  Created by 孙恺 on 15/11/26.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySelectDelegate <NSObject>

- (void)didSelectCityWithName:(NSString *)cityName;

@end

@interface CitySelectTableViewController : UITableViewController

@property (nonatomic, strong) NSString *provinceName;

@property(nonatomic, assign) id<CitySelectDelegate>delegete;

@property (nonatomic, retain) NSDictionary *cities;
@property (nonatomic, retain) NSArray *keys;
//@property (nonatomic, assign) BOOL draggable; // Default: YES

@end
