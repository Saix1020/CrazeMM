//
//  MineSupplyInfoViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineSupplyInfoViewController : UIViewController
@property (nonatomic, readonly) NSInteger sid;

-(instancetype)initWithId:(NSUInteger)sid;
-(void)deplayTimeLine: (NSArray*)logs;

@end
