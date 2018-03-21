//
//  UploadSignImgService.m
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UploadSignImgService.h"

@implementation UploadSignImgService
{
    NSString *_docid;
    NSString *_signimg;
}

-(instancetype)initWithDocid:(NSString *)docid signimg:(UIImage *)signimg
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        
        
        NSData *data = UIImageJPEGRepresentation(signimg, 0.01);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        _signimg = encodedImageStr;
        
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
    
    return @"/webservice/doctor.asmx/UploadSignImg";
}

-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"signimg":_signimg,
             
             };
    
}





@end
