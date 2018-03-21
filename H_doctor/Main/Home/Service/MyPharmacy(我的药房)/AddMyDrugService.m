//
//  AddMyDrugService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/14.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AddMyDrugService.h"

@implementation AddMyDrugService
{
    NSString *_docid;
    NSString *_medcid;
    
}

-(instancetype)initWithDocid:(NSString *)docid medcid:(NSString *)medcid
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _medcid = medcid;
        
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
    
    return @"/webservice/doctor.asmx/AddMedcToDrugStore";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"medcid":_medcid,
             };
    
}
@end
