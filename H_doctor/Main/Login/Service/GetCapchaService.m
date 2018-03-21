//
//  GetCapchaService.m
//  hospital
//
//  Created by zhiren on 2017/8/15.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "GetCapchaService.h"

@implementation GetCapchaService
{
    NSString *_phoneNum;
    
}


-(instancetype)initRegistWithPhoneNum:(NSString *)phoneNum
{
    
    self = [super init];
    if (self) {
        
        _phoneNum = phoneNum;
        
        
    }
    return self;
    
    
}


- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodGET;
}


- (NSTimeInterval)requestTimeoutInterval
{
    return 60;
}


- (NSString *)requestUrl {
    
    return @"/webservice/doctor.asmx/SendTelCode1";
}


-(id)requestArgument
{
    return @{
             @"tel":_phoneNum,
             
             };
    
}



@end
