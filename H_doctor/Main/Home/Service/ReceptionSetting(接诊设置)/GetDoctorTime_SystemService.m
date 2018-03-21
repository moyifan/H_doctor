//
//  GetDoctorTime_SystemService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/20.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetDoctorTime_SystemService.h"

@implementation GetDoctorTime_SystemService


-(instancetype)init{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodGET;
}


- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}


- (NSString *)requestUrl {
    
    return @"/webservice/doctor.asmx/GetDoctorTime_System";
}





@end
