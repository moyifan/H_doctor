//
//  GetMySickerByKeywordService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/20.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetMySickerByKeywordService.h"

@implementation GetMySickerByKeywordService

{
    NSString *_docid;
    NSString *_keyword;
    
}
-(instancetype)initWithDocid:(NSString *)docid keyword:(NSString *)keyword
{
    self = [super init];
    if (self) {
        
        _docid = docid;
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
    
    return @"/webservice/doctor.asmx/GetMySickerByKeyword";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"keyword":_keyword,
             };
    
}
@end
