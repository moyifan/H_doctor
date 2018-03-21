//
//  GetSicknessByKeywordService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetSicknessByKeywordService.h"

@implementation GetSicknessByKeywordService
{
    NSString *_page;
    NSString *_keyword;
}
-(instancetype)initWithPagesize:(NSString *)pagesize page:(NSString *)page keyword:(NSString *)keyword
{
    
    self = [super init];
    if (self) {
        
        _page = page;
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
    
    return @"/webservice/doctor.asmx/GetSicknessByKeyword";
}


-(id)requestArgument
{
    return @{
             @"pagesize":@"100",
             @"page":_page,
             @"keyword":_keyword,
             };
    
}


@end
