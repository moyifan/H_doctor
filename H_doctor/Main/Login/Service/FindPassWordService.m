//
//  FindPassWordService.m
//  hospital
//
//  Created by zhiren on 2017/8/17.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "FindPassWordService.h"

@implementation FindPassWordService

{
    NSString *_phoneNum;
    NSString *_passWord;
    
    NSString *_verificationCode;  // 验证码
}


-(instancetype)initRegistWithPhoneNum:(NSString *)phoneNum verificationCode:(NSString *)verificationCode passWord:(NSString *)passWord
{
    self = [super init];
    if (self) {
        
        _phoneNum = phoneNum;
        _passWord = passWord;
        
        _verificationCode = verificationCode;
        
    }
    return self;
        
    
}


- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}


- (NSTimeInterval)requestTimeoutInterval
{
    return 60;
}


- (NSString *)requestUrl {
    
    return @"/app/user/resetPassword";
}


-(id)requestArgument
{
    return @{
             @"phoneNo":_phoneNum,
             @"password":_passWord,
             
             @"captcha":_verificationCode,
             };
    
}

@end
