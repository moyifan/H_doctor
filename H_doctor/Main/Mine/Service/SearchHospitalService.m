//
//  SearchHospitalService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/13.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "SearchHospitalService.h"

@implementation SearchHospitalService
{
    NSString *_keyword;
}
-(instancetype)initWithKeyword:(NSString *)keyword
{
    self = [super init];
    if (self) {
        
        _keyword = keyword;
        
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
    
    return @"/webservice/doctor.asmx/SearchHosptl";
}

-(id)requestArgument
{
    return @{
             @"keyword":_keyword,
             
             };
    
}


@end
