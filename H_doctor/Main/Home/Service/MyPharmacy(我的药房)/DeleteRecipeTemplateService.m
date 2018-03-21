//
//  DeleteRecipeTemplateService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/15.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "DeleteRecipeTemplateService.h"

@implementation DeleteRecipeTemplateService

{
    NSString *_docid;
    NSString *_detailid;
}

-(instancetype)initWithDocid:(NSString *)docid detailid:(NSString *)detailid{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _detailid = detailid;
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
    
    return @"/webservice/doctor.asmx/DeleteRecipeTempletChild_Temp";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"detailid":_detailid,
             };
    
}



@end
