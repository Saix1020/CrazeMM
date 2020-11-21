//
//  CommonListCell+PayRecord.h
//  CrazeMM
//
//  Created by Mao Mao on 16/8/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonListCell.h"
#import "PayRecordDTO.h"

@interface CommonListCell (PayRecord)

@property (nonatomic, readonly) PayRecordDTO* payRecordDto;

@end
