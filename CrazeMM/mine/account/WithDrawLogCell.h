//
//  WithDrawLogCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "RechargeLogCell.h"
#import "WithDrawLogDTO.h"

@interface WithDrawLogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *bankDescLabel;

@property (nonatomic, strong) WithDrawLogDTO* withDrawLogDto;

@end
