//
//  GetChatListService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/1.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetChatListService.h"

@implementation GetChatListService
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
    return 60;
}


- (NSString *)requestUrl {
    
    return @"/webservice/doctor_socket.asmx/GetQueue";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             
             };
    
}

@end
