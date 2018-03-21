//
//  ReceiveService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/1.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ReceiveService.h"

@implementation ReceiveService
{
    NSString *_docid;
    NSString *_dstid;
    NSString *_caseid;

}

-(instancetype)initWithDocid:(NSString *)docid dstid:(NSString *)dstid caseid:(NSString *)caseid
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _dstid = dstid;
        _caseid = caseid;
        
        
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
    
    return @"/webservice/doctor_socket.asmx/StartInquiry";
}


-(id)requestArgument
{
    return @{
             @"srcid":_docid,
             @"dstid":_dstid,
             @"caseid":_caseid,

             };
    
}

@end
