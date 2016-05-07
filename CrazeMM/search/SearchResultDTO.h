//
//  SearchResultDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

//deadlineStr = "72\U5c0f\U65f6\U4ee5\U4e0a";
//                            duration = 24;
//                            goodName = "\U82f9\U679c-iPhone SE \U7c89 16G \U5168\U7f51\U901a";
//                            id = 1660;
//                            intentions = 1;
//                            isActive = 1;
//                            isAnoy = 0;
//                            isStep = 0;
//                            millisecond = 48977492;
//                            price = 1;
//                            quantity = 10;
//                            region = "\U4e0a\U6d77";
//                            stateLabel = "\U6b63\U5e38";
//                            userImage = "http://www.189mm.com:8080/upload/user/1_cut.jpg";
//                            userName = 189mm;
//                            views = 5;

@interface SearchResultDTO : BaseDTO

@property (nonatomic, copy) NSString* deadlineStr;
@property (nonatomic) NSInteger duration;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic) NSInteger intentions;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isAnoy;
@property (nonatomic) BOOL isStep;
@property (nonatomic) NSInteger millisecond;
@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger quantity;
@property (nonatomic, copy) NSString* region;
@property (nonatomic, copy) NSString* stateLabel;
@property (nonatomic, copy) NSString* userImage;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic) NSInteger views;
-(instancetype)initWith:(NSDictionary*)dict;

@end