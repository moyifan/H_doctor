//
//  SaveDoctorTimeService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/20.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "SaveDoctorTimeService.h"

@implementation SaveDoctorTimeService

{
    NSString *_docid;
    NSString *_weekid;
    NSString *_timecollection;

}


-(instancetype)initWithDocid:(NSString *)docid weekid:(NSString *)weekid timecollection:(NSString *)timecollection
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _weekid = weekid;
        _timecollection = timecollection;
        
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
    
    return @"/webservice/doctor.asmx/SaveDoctorTime";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"weekid":_weekid,
             @"timecollection":_timecollection,
             };
    
}

@end
