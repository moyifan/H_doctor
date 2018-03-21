//
//  UpdateSectionService.m
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateSectionService.h"

@implementation UpdateSectionService
{
    NSString *_docid;
    NSString *_sectionid;
    
}
-(instancetype)initWithDocid:(NSString *)docid sectionid:(NSString *)sectionid
{
    
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        _sectionid = sectionid;
        
        
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
    
    return @"/webservice/doctor.asmx/UpdateSection";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"sectionid":_sectionid,
             
             };
    
}
@end
