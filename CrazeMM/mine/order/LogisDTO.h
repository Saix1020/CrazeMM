//
//  LogisDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface LogisDTO : BaseDTO
//{"data":[{"querySite":"http:\/\/www.kuaidi100.com\/all\/sf.shtml?from=newindex","name":"顺丰快递","id":1},{"querySite":"http:\/\/www.kuaidi100.com\/all\/st.shtml?from=newindex","name":"申通快递","id":2},{"querySite":"http:\/\/www.kuaidi100.com\/all\/yt.shtml?from=newindex","name":"圆通快递","id":3},{"querySite":"http:\/\/www.kuaidi100.com\/all\/zt.shtml?from=newindex","name":"中通快递","id":4},{"querySite":"http:\/\/www.kuaidi100.com\/all\/yd.shtml?from=newindex","name":"韵达快递","id":5},{"querySite":"http:\/\/www.kuaidi100.com\/all\/ems.shtml?from=newindex","name":"EMS","id":6},{"querySite":"http:\/\/www.kuaidi100.com\/global\/lianb.shtml","name":"联邦快递","id":7},{"querySite":"http:\/\/www.kuaidi100.com\/all\/tt.shtml","name":"天天快递","id":8},{"querySite":"http:\/\/www.kuaidi100.com\/all\/zjs.shtml","name":"宅急送","id":9}],"ok":true}
@property (nonatomic, copy) NSString* querySite;
@property (nonatomic, copy) NSString* name;

@end
