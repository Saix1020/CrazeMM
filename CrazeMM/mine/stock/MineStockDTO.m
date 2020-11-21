//
//  MineStockDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineStockDTO.h"

@implementation MineStockDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.depotDto = [[DepotDTO alloc] initWith:dict[@"depot"]];
    
        self.inprice = [dict[@"inprice"] floatValue];
        self.gid = [dict[@"gid"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
        self.depotId = [dict[@"depotId"] integerValue];
        self.version = [dict[@"version"] integerValue];
        
        self.afterout = [dict[@"afterout"] integerValue];
        self.inmortgage = [dict[@"inmortgage"] integerValue];
        self.insale = [dict[@"insale"] integerValue];
        self.aftersale = [dict[@"aftersale"] integerValue];
        self.presale = [dict[@"presale"] integerValue];
        self.outstock = [dict[@"outstock"] integerValue];

        
        
        self.isSerial = [dict[@"isSerial"] boolValue];
        self.isOriginal = [dict[@"isOriginal"] boolValue];
        self.isOriginalBox = [dict[@"isOriginalBox"] boolValue];
        self.isBrushMachine = [dict[@"isBrushMachine"] boolValue];

        self.updateTime = dict[@"updateTime"];
        self.depotName = dict[@"depotName"];
        self.gimage = dict[@"gimage"];
        self.gvolume = dict[@"gvolume"];
        self.goodName = dict[@"goodName"];
        self.goodImage = dict[@"goodImage"];

        self.gnetwork = dict[@"gnetwork"];
        self.gnetwork = dict[@"gcolor"];

        
        self.state = [dict[@"state"] integerValue];
        self.stateLabel = dict[@"stateLabel"];
        
        self.currentPrice = self.inprice;
        self.currentSale = self.presale;
        self.currentNum = self.seperateNum = 1;

        self.selected = NO;
    }
    return self;
}

-(NSInteger)total
{
    return _presale + _insale + _outstock + _afterout + _inmortgage + _aftersale;
}

-(NSAttributedString*)presaleString
{
    UIColor* color = [UIColor grayColor];

    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可售 %ld ", self.presale]
                                                                                        attributes:@{
                                                                                                     NSForegroundColorAttributeName:color,
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:12.f]                                                      }];
    
    
    return attributeString;
}
-(NSAttributedString*)insaleString
{
    UIColor* color = [UIColor redColor];
    
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"在售 %ld ", self.insale]
                                                                                        attributes:@{
                                                                                                     NSForegroundColorAttributeName:color,
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:12.f]                                                      }];
    
    
    return attributeString;
}
-(NSAttributedString*)aftersaleString
{
    UIColor* color = [UIColor blueColor];
    
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已售 %ld ", self.aftersale]
                                                                                        attributes:@{
                                                                                                     NSForegroundColorAttributeName:color,
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:12.f]                                                      }];

    
    return attributeString;
}
-(NSAttributedString*)outstockString
{
    UIColor* color = [UIColor redColor];
    
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待出库 %ld ", self.outstock]
                                                                                        attributes:@{
                                                                                                     NSForegroundColorAttributeName:color,
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:12.f]                                                      }];
    
    
    return attributeString;
}
-(NSAttributedString*)afteroutString
{
    UIColor* color = [UIColor blueColor];
    
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已出库 %ld ", self.afterout]
                                                                                        attributes:@{
                                                                                                     NSForegroundColorAttributeName:color,
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:12.f]                                                      }];
    
    
    return attributeString;
}
-(NSAttributedString*)inmortgageString
{
    UIColor* color = [UIColor grayColor];
    
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已抵押 %ld ", self.inmortgage]
                                                                                        attributes:@{
                                                                                                     NSForegroundColorAttributeName:color,
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:12.f]                                                      }];
    
    
    return attributeString;
}

-(NSAttributedString*)statusDesc
{
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] init];
    
    //content += '        <p class="good_info">';
    //content += (stock['presale']>0?'<span>可售&nbsp;' + stock['presale'] +'</span>':'');
    //content += (stock['insale']>0?'<span class="red">在售&nbsp;' + stock['insale'] + '</span>':'');
    //content += (stock['aftersale']>0?'<span class="blue">已售&nbsp;' + stock['aftersale'] +'</span>':'');
    //content += (stock['outstock']>0?'<span class="red">待出库&nbsp;' + stock['outstock'] + '</span>':'');
    //content += (stock['afterout']>0?'<span class="blue">已出库&nbsp;' + stock['afterout'] +'</span>':'');
    //content += (stock['inmortgage']>0?'<span>已抵押&nbsp;：' + stock['inmortgage'] + '</span>':'');
    
    if(_presale>0){
        [attributeString appendAttributedString:[self presaleString]];
    }
    if(_insale>0){
        [attributeString appendAttributedString:[self insaleString]];
    }
    if (_aftersale>0) {
        [attributeString appendAttributedString:[self aftersaleString]];
    }
    if(_outstock>0){
        [attributeString appendAttributedString:[self outstockString]];

    }
    if(_afterout>0){
        [attributeString appendAttributedString:[self afteroutString]];

    }
    if(_inmortgage>0) {
        [attributeString appendAttributedString:[self inmortgageString]];
    }
    
    return attributeString;
}

-(instancetype)initWithStockDetailDTO:(StockDetailDTO*)stockDetailDto
{
    self = [super init];
    if (self) {
        self.gid = stockDetailDto.gid;
        self.depotId = stockDetailDto.depotId;
        self.version = stockDetailDto.version;
        self.uid = stockDetailDto.uid;
        self.inprice = stockDetailDto.inprice;
        self.isSerial = stockDetailDto.isSerial;
        self.isOriginal = stockDetailDto.isOriginal;
        self.isOriginalBox = stockDetailDto.isOriginalBox;
        self.updateTime = stockDetailDto.updateTime;
        self.gvolume = stockDetailDto.gvolume;
        self.gnetwork = stockDetailDto.gnetwork;
        self.gcolor = stockDetailDto.gcolor;
        self.goodName = stockDetailDto.goodName;
        
        self.afterout = stockDetailDto.afterout;
        self.inmortgage = stockDetailDto.inmortgage;
        self.insale = stockDetailDto.insale;
        self.aftersale = stockDetailDto.aftersale;
        self.presale = stockDetailDto.presale;
        self.outstock = stockDetailDto.outstock;
        
        
        self.currentPrice = self.inprice;
        self.currentSale = self.presale;
        self.currentNum = self.seperateNum = 1;
        self.selected = NO;

    }
    return self;
}

@end
