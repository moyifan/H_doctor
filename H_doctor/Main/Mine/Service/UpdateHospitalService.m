//
//  UpdateHospitalService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/13.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateHospitalService.h"

@implementation UpdateHospitalService

{
    NSString *_docid;
    NSString *_hosptlid;
    
}

-(instancetype)initWithDocid:(NSString *)docid hosptlid:(NSString *)hosptlid
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        _hosptlid = hosptlid;
        
        
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
    
    return @"/webservice/doctor.asmx/UpdateHosptl";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"hosptlid":_hosptlid,
             
             };
    
}


@end
