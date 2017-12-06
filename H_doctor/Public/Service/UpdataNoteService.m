//
//  UpdataNoteService.m
//  hospital
//
//  Created by zhiren on 2017/9/22.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "UpdataNoteService.h"

@implementation UpdataNoteService
{
    NSString *_type;
    NSString *_noteID;
    NSString *_accept;
}
-(instancetype)initUpdataNoteWithNoteId:(NSString *)noteId type:(NSString *)type accept:(NSString *)accept
{
    
    self = [super init];
    if (self) {
        
        _noteID = noteId;
        _type = type;
        _accept = accept;
        
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
    
    return @"/app/note/updateNote";
}


-(id)requestArgument
{
    NSLog(@" %@ %@ %@ %@ %@ ",_noteID,HospitalUserDefault.doctorID,_type,HospitalUserDefault.payMent,_accept);
    return @{
             @"noteId":_noteID,
             @"doctorId":HospitalUserDefault.doctorID,
             @"type":_type,
             @"payment":HospitalUserDefault.payMent,
             @"accept":_accept,
             };
    
}
@end
