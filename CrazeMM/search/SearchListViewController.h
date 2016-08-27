//
//  SearchListViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"
#import "FilterViewController.h"

@interface SearchListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CustomSegmentDelegate, UISearchBarDelegate, UIScrollViewDelegate,
FilterViewControllerDelegate>

-(instancetype)initWithKeyword:(NSString*)keyword;

@end
