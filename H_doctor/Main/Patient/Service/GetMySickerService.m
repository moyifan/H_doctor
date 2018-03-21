//
//  GetMySickerService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/20.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetMySickerService.h"

@implementation GetMySickerService
{
    NSString *_docid;
}
-(instancetype)initWithDocid:(NSString *)docid
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        
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
    
    return @"/webservice/doctor.asmx/GetMySicker";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             
             };
    
}
@end
