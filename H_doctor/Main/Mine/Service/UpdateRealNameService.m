//
//  UpdateRealNameService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateRealNameService.h"

@implementation UpdateRealNameService
{
    NSString *_docid;
    NSString *_realname;
    
}

-(instancetype)initWithDocid:(NSString *)docid realname:(NSString *)realname
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        _realname = realname;
        
        
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
    
    return @"/webservice/doctor.asmx/UpdateRealName";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"realname":_realname,
             
             };
    
}

@end
