//
//  GetPatientService.m
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetPatientService.h"

@implementation GetPatientService
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
    
    return @"/webservice/doctor.asmx/GetSignSicker";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             
             };
    
}

@end