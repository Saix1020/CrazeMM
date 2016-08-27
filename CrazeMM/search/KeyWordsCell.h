//
//  KeyWordsCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSeperatorLineCell.h"

typedef void(^signalBlock)(id data);


@interface KeyWordsCell : CustomSeperatorLineCell

@property (nonatomic, strong) NSArray* keywords;
@property (nonatomic, readonly) CGFloat cellHight;
@property (nonatomic, strong) signalBlock block;

-(void)setKeywords:(NSArray *)keywords andBlock:(signalBlock)block;

@end
