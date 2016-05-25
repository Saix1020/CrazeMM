//
//  SuggestViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuggestVCDelegate <NSObject>

-(void)didSelectSuggestString:(NSString*)selectedString;

@end

@interface SuggestViewController : UITableViewController

@property (nonatomic, weak) id<SuggestVCDelegate> delegate;
@property (nonatomic, copy) NSArray* suggestedStrings;

@property (nonatomic) CGFloat height;
@property (nonatomic, strong) NSIndexPath* selectedIndexPath;


-(instancetype)initWithSelectedIndexPath:(NSIndexPath*)indexPath;

@end
