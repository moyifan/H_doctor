//
//  GetRecipeTempletChildListByID.m
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetRecipeTempletChildListByID.h"

@implementation GetRecipeTempletChildListByID
{
    NSString *_ID;
}
-(instancetype)initWithID:(NSString *)ID
{
    
    self = [super init];
    if (self) {
        
        _ID = ID;
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
    
    return @"/webservice/doctor.asmx/GetRecipeTempletChildListByID";
}


-(id)requestArgument
{
    return @{
             @"id":_ID,
             };
    
}

@end
