//
//  GetDrugListService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/14.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "GetDrugListService.h"

@implementation GetDrugListService


{
    NSString *_docid;
    NSString *_page;

}

-(instancetype)initWithDocid:(NSString *)docid page:(NSString *)page
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _page = page;
        
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
    
    return @"/webservice/doctor.asmx/GetMedcList";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"pagesize":@"20",
             @"page":_page,
             };
    
}
@end
