//
//  DepotDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface DepotDTO : BaseDTO

//{"depot":[{"name":"良晋栖霞仓库","id":2,"info":"位于江苏省南京市栖霞区"},{"name":"良晋浦口仓库","id":3,"info":"位于江苏省南京市浦口区"},{"name":"良晋江宁仓库","id":4,"info":"位于江苏省南京市江宁区"}],"ok":true}

@property (nonatomic, copy) NSString*  name;
@property (nonatomic, copy) NSString*  info;

@end
