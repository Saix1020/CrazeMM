//
//  FilterButton.h
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterTagLabelDelegate <NSObject>

-(void)didTaped:(id)sender;

@end


@interface FilterTagLabel : UILabel

@property (nonatomic) BOOL isSelected;
@property (nonatomic, strong) NSString* filterTag;
//-(void)toggleSelect;

@property (nonatomic, weak) id<FilterTagLabelDelegate> delegate;

@end
