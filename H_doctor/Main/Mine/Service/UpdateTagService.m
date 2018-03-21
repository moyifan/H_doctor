//
//  UpdateTagService.m
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateTagService.h"

@implementation UpdateTagService
{
    NSString *_docid;
    NSString *_tagname;
 
}
-(instancetype)initWithDocid:(NSString *)docid tagname:(NSString *)tagname
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        _tagname = tagname;
        
        
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
    
    return @"/webservice/doctor.asmx/UpdateTag";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"tagname":_tagname,
             
             };
    
}
@end
