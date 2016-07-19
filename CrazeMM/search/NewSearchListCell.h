//
//  NewSearchListCell.h
//  CrazeMM
//
//  Created by saix on 16/5/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultDTO.h"

@interface NewSearchListCell : UITableViewCell

@property (nonatomic, strong) SearchResultDTO* searchResultDto;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSString*)type;


@end
