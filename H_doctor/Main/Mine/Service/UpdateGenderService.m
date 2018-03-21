//
//  UpdateGenderService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/13.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateGenderService.h"

@implementation UpdateGenderService

{
    NSString *_docid;
    NSString *_gender;
    
}
-(instancetype)initWithDocid:(NSString *)docid gender:(NSString *)gender
{
    
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        _gender = gender;
        
        
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
    
    return @"/webservice/doctor.asmx/UpdateGender";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"gender":_gender,
             
             };
    
}


@end
