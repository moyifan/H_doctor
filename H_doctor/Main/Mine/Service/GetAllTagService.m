//
//  GetAllTagService.m
//  H_doctor
//
//  Created by zhiren on 2018/2/23.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetAllTagService.h"

@implementation GetAllTagService

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
    
    return @"/webservice/doctor.asmx/GetAllTag";
}

@end
