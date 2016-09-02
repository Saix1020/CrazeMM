//
//  HttpUserInfo.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "MineUserInfoDTO.h"

@interface HttpUserInfoRequest : BaseHttpRequest

@end

@interface HttpUserInfoResponse : BaseHttpResponse

@property (nonatomic, readonly) NSDictionary* me;
@property (nonatomic ,strong) MineUserInfoDTO* mineUserInfoDto;

@end

///rest/user/updateValidated
@interface HttpUserUpdateValidatedRequest : BaseHttpRequest

-(instancetype)initWithUserInfo:(MineUserInfoDTO*)userInfo;

@end