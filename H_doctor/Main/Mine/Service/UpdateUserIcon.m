//
//  UpdateUserIcon.m
//  H_doctor
//
//  Created by zhiren on 2018/2/23.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateUserIcon.h"

@implementation UpdateUserIcon
{
    NSString *_docId;
    NSString *_img;
}

-(instancetype)initWithDocid:(NSString *)docId Img:(UIImage *)img
{
    self = [super init];
    if (self) {
        
        _docId = docId;
        
        NSData *data = UIImageJPEGRepresentation(img, 0.01);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        _img = encodedImageStr;
        
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
    
    return @"/webservice/doctor.asmx/UploadDocImg";
}

-(id)requestArgument
{
    return @{
             @"docid":_docId,
             @"img":_img,

             };
    
}



@end
