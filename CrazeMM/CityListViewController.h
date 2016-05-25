//
//  CitySelectTableViewController.h
//  Wear
//
//  Created by 孙恺 on 15/11/26.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityListDelegate <NSObject>

- (void)didSelectCityWithName:(NSString *)cityName;

@end

@interface CityListViewController : UIViewController {
    NSDictionary *cities;  
    NSArray *keys;
}

@property(nonatomic, assign) id<CityListDelegate>delegete;

@property (nonatomic, retain) NSDictionary *cities;  
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, assign) BOOL draggable; // Default: YES

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
