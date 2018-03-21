//
//  UploadCertService.m
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UploadCertService.h"

@implementation UploadCertService
{
    NSString *_docid;
    NSString *_certcode;
    NSString *_certimg;
}


-(instancetype)initWithDocid:(NSString *)docid certcode:(NSString *)certcode certimg:(UIImage *)certimg
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        _certcode = certcode;
        
        NSData *data = UIImageJPEGRepresentation(certimg, 0.01);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        _certimg = encodedImageStr;
        
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
    
    return @"/webservice/doctor.asmx/UploadCert";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"certcode":_certcode,
             @"certimg":_certimg,
             
             };
    
}








@end
