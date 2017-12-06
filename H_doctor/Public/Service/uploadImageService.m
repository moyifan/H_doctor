//
//  uploadImageService.m
//  gang
//
//  Created by zhiren on 2016/10/14.
//  Copyright © 2016年 zhiren. All rights reserved.
//

#import "uploadImageService.h"

@implementation uploadImageService
{
    UIImage *_Path;
    
}

-(instancetype)initWithUploadAndImagePath:(UIImage *)Path
{
    self = [super init];
    if (self) {
        
        _Path = Path;
        
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
    
    return @"/app/user/upload";
}


- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        
//        NSData *data = [NSData dataWithContentsOfFile:_Path];
        NSData *data = UIImageJPEGRepresentation(_Path, 0.01);
        NSString *name = @"file";
        NSString *type = @"image/jpg";
        
        
        
        NSString *fileName = @"";
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *day = [formatter stringFromDate:[NSDate date]];
        
        fileName = [NSString stringWithFormat:@"%@.%@",day,type];

             
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
        
    };
}



//-(NSString *)responseData
//{
//    return @"";
//}





@end
