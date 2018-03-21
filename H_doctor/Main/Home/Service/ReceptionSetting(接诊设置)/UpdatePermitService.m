//
//  UpdatePermitService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdatePermitService.h"

@implementation UpdatePermitService
{
    NSString *_docid;
    NSString *_status;
    NSString *_who;

}

-(instancetype)initWithDocid:(NSString *)docid status:(NSString *)status who:(NSString *)who{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _status = status;
        _who = who;
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
    
    return [NSString stringWithFormat:@"/webservice/doctor.asmx/%@",_who];
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"status":_status,
             };
    
}
@end
