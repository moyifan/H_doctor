//
//  UpdateExpertiseService.m
//  H_doctor
//
//  Created by zhiren on 2018/2/26.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateExpertiseService.h"

@implementation UpdateExpertiseService
{
    NSString *_docid;
    NSString *_expertise;
    
}
-(instancetype)initWithDocid:(NSString *)docid expertise:(NSString *)expertise
{
    
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        _expertise = expertise;
        
        
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
    
    return @"/webservice/doctor.asmx/UpdateExpertise";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"expertise":_expertise,
             
             };
    
}

@end
