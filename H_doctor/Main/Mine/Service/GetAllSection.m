//
//  GetAllSection.m
//  H_doctor
//
//  Created by zhiren on 2018/2/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetAllSection.h"

@implementation GetAllSection

-(instancetype)init
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
    
    return @"/webservice/doctor.asmx/GetAllSection";
}


@end
