//
//  GetRecipeTempletByKeywordService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetRecipeTempletByKeywordService.h"

@implementation GetRecipeTempletByKeywordService
{
    NSString *_docid;
    NSString *_type;
    NSString *_keyword;
}

-(instancetype)initWithDocid:(NSString *)docid type:(NSString *)type keyword:(NSString *)keyword
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _type = type;
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
    
    return @"/webservice/doctor.asmx/GetRecipeTempletByKeyword";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"type":_type,
             @"keyword":_keyword,
             };
    
}


@end
