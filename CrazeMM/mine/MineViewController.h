//
//  MineViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MineTableViewSection){
    kSectionOverview = 0,
    kSectionInfo,
    kSectionContact,
    kSectionMax
};


@interface MineViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@end
