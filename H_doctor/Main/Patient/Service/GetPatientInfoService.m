//
//  GetPatientInfoService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/20.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetPatientInfoService.h"

@implementation GetPatientInfoService
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
    
    return @"/webservice/doctor.asmx/GetSignSickerInfo";
}

-(id)requestArgument
{
    return @{
             @"userid":_docid,
             
             };
    
}
@end
