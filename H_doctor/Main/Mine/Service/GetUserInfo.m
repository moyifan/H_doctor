//
//  GetUserInfo.m
//  H_doctor
//
//  Created by zhiren on 2018/2/11.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetUserInfo.h"

@implementation GetUserInfo
{
    NSString *_userId;

}


-(instancetype)initWithUserId:(NSString *)userId{
    self = [super init];
    if (self) {
        
        _userId = userId;

        
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
    
    return @"/webservice/doctor.asmx/GetDocInfo";
}


-(id)requestArgument
{
    return @{
             @"docid":_userId,

             };
    
}

@end
