//
//  SearchViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SearchType){
    kSearchTypeBuy = 0,
    kSearchTypeSell = 1
};

@interface SearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

-(instancetype)initWithType:(SearchType)searchType;

@end
