//
//  UploadIDCard.m
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UploadIDCard.h"

@implementation UploadIDCard
{
    NSString *_docid;
    NSString *_front;
    NSString *_back;
}
-(instancetype)initWithDocid:(NSString *)docid front:(UIImage *)front back:(UIImage *)back
{
    
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        NSData *datafront = UIImageJPEGRepresentation(front, 0.01);
        
        NSString *encodedImageStr = [datafront base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        _front = encodedImageStr;
        
        
        NSData *databack = UIImageJPEGRepresentation(back, 0.01);
        
        NSString *encodedImageStr1 = [databack base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        _back = encodedImageStr1;
        
        
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
    
    return @"/webservice/doctor.asmx/UploadSfz";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"front":_front,
             @"back":_back,
             
             };
    
}


@end
