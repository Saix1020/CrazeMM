//
//  SearchListViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"

@interface SearchListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CustomSegmentDelegate>

-(instancetype)initWithKeyword:(NSString*)keyword;

@end
