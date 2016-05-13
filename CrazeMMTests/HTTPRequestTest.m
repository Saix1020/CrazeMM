//
//  HTTPRequestTest.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HttpCheckPictureCaptchaRequest.h"
#import "HttpLoginRequest.h"
#import "HttpGenMobileVcodeRequest.h"
#import "HttpMobileExistCheckRequest.h"
#import "HttpCheckMessageCodeRequest.h"
#import "HttpSignupRequest.h"


@interface HTTPRequestTest : XCTestCase

@end

@implementation HTTPRequestTest


- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testLogin
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"High Expectations"];
    
    HttpLoginRequest* loginHttp = [[HttpLoginRequest alloc] initWithUser:@"xuanxuan" andPassword:@"123456" andRemember:YES];
    [loginHttp request2].then(^(id responseObject, AFHTTPRequestOperation *operation){
        
        NSLog(@"%@", responseObject);
        [expectation fulfill];
    }).catch(^(NSError *error){
        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
    });
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];}

-(void)testCheckPictureCaptcha
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"High Expectations"];
    
    HttpCheckPictureCaptchaRequest* checkPictureCaptchaRequest = [[HttpCheckPictureCaptchaRequest alloc] initWithPicCaptacha:@"ASDF"];
    [checkPictureCaptchaRequest request2].then(^(id responseObject, AFHTTPRequestOperation *operation){
    
        NSLog(@"%@", responseObject);
        [expectation fulfill];
    }).catch(^(NSError *error){
        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
    });;
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
}

-(void)testGenMobileVcode
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    HttpGenMobileVcodeRequest* request = [[HttpGenMobileVcodeRequest alloc] initWithPicCaptacha:@"ASDF" andMobile:@"13913872708"];
    [request request2].then(^(id responseObject, AFHTTPRequestOperation *operation){
        
        NSLog(@"%@", responseObject);
        [expectation fulfill];
    }).catch(^(NSError *error){
        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
    });
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

-(void)testMobileExist
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    HttpMobileExistCheckRequest* request = [[HttpMobileExistCheckRequest alloc] initWithMobile:@"13913872708"];
    [request request2].then(^(id responseObject, AFHTTPRequestOperation *operation){
        
        NSLog(@"%@", responseObject);
        [expectation fulfill];
    }).catch(^(NSError *error){
        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
    });
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

-(void)testCheckMobileCode
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    HttpCheckMessageCodeRequest* request = [[HttpCheckMessageCodeRequest alloc] initWithMobileCode:@"1234" andMobile:@"13776573631"];
    [request request2].then(^(id responseObject, AFHTTPRequestOperation *operation){
        
        NSLog(@"%@", responseObject);
        [expectation fulfill];
    }).catch(^(NSError *error){
        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
    });
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

-(void)testSignup
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    HttpSignupRequest* request = [[HttpSignupRequest alloc] initWithMobile:@"13776573631" andCaptchaPhone:@"1234" andPassword:@"ASB#1234" andPictureCaptcha:@"ASDF"];
    [request request2].then(^(id responseObject, AFHTTPRequestOperation *operation){
        
        NSLog(@"%@", responseObject);
        [expectation fulfill];
    }).catch(^(NSError *error){
        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
    });
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
