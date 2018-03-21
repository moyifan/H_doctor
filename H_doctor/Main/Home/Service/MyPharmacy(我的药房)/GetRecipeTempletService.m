//
//  GetRecipeTempletService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetRecipeTempletService.h"

@implementation GetRecipeTempletService

{
    NSString *_docid;
    NSString *_type;
}

-(instancetype)initWithDocid:(NSString *)docid type:(NSString *)type{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _type = type;
        
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodGET;
}


- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}


- (NSString *)requestUrl {
    
    return @"/webservice/doctor.asmx/GetRecipeTemplet";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"type":_type,
             };
    
}



@end
