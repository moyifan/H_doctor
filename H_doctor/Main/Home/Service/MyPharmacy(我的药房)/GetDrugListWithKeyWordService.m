//
//  GetDrugListWithKeyWordService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/14.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetDrugListWithKeyWordService.h"

@implementation GetDrugListWithKeyWordService

{
    NSString *_docid;
    NSString *_page;
    NSString *_keyword;
}

-(instancetype)initWithDocid:(NSString *)docid page:(NSString *)page keyword:(NSString *)keyword
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _page = page;
        _keyword = keyword;
        
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
    
    return @"/webservice/doctor.asmx/GetMedcListByKeyword";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"pagesize":@"20",
             @"page":_page,
             @"keyword":_keyword,
             };
    
}



@end
