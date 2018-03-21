//
//  LoginService.m
//  H_doctor
//
//  Created by zhiren on 2018/1/15.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService

{
    NSString *_phoneNum;
    NSString *_passWord;
}
-(instancetype)initLoginWithPhoneNum:(NSString *)phoneNum passWord:(NSString *)passWord
{
    self = [super init];
    if (self) {
        
        _phoneNum = phoneNum;
        _passWord = passWord;
        
        
    }
    return self;
    
}


- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}


- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}


- (NSString *)requestUrl {
    
    return @"/webservice/doctor.asmx/Login";
}


-(id)requestArgument
{
    return @{
             @"tel": _phoneNum,
             @"pwd": _passWord,

             };

}

 




@end
