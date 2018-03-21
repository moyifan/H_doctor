//
//  GetDoctorTimeService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetDoctorTimeService.h"

@implementation GetDoctorTimeService


{
    NSString *_docid;
    
}

-(instancetype)initWithDocid:(NSString *)docid{
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        
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
    
    return @"/webservice/doctor.asmx/GetDoctorTime";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             };
    
}


@end
