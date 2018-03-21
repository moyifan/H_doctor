//
//  GetSignSickerAllInquiryService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/20.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetSignSickerAllInquiryService.h"

@implementation GetSignSickerAllInquiryService

{
    NSString *_docid;
    NSString *_type;
    
}
-(instancetype)initWithDocid:(NSString *)docid type:(NSString *)type
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _type = type;
        
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
    
    return @"/webservice/doctor.asmx/GetSignSickerAllInquiry";
}

-(id)requestArgument
{
    return @{
             @"userid":_docid,
             @"type":_type,
             };
    
}
@end
