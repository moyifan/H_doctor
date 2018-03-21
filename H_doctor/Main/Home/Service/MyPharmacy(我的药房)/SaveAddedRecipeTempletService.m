//
//  SaveAddedRecipeTempletService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "SaveAddedRecipeTempletService.h"

@implementation SaveAddedRecipeTempletService

{
    NSString *_docid;
    NSString *_title;
    NSString *_sicknessid;
    NSString *_title_diy;
    
}
-(instancetype)initWithDocid:(NSString *)docid title:(NSString *)title sicknessid:(NSString *)sicknessid title_diy:(NSString *)title_diy
{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _title = title;
        _sicknessid = sicknessid;
        _title_diy = title_diy;

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
    
    return @"/webservice/doctor.asmx/SaveAddedRecipeTemplet";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"title":_title,
             @"sicknessid":_sicknessid,
             @"title_diy":_title_diy,
             @"type":@"0",
             
             };
    
}

@end
