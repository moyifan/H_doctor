//
//  GetProvCityAndHospitalService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetProvCityAndHospitalService.h"

@implementation GetProvCityAndHospitalService

-(instancetype)initWithProvCityAndHospital
{
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
    
    return @"/webservice/doctor.asmx/GetProvCityAndHosptl";
}


@end
