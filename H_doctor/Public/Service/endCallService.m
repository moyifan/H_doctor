//
//  endCallService.m
//  hospital
//
//  Created by zhiren on 2017/9/27.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "endCallService.h"

@implementation endCallService
{
    NSString *_noteID;
}
-(instancetype)initEndCallWithNoteId:(NSString *)noteId
{
    
    self = [super init];
    if (self) {
        
        _noteID = noteId;
        
    }
    return self;
    
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}


- (NSTimeInterval)requestTimeoutInterval
{
    return 60;
}


- (NSString *)requestUrl {
    
    return @"/app/user/userEndTreatment";
}


-(id)requestArgument
{
    return @{
             @"noteId":_noteID,
             @"userId":HospitalUserDefault.ID
             };
    
}


@end
