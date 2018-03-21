//
//  AddRecipeTempletChildService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AddRecipeTempletChildService.h"

@implementation AddRecipeTempletChildService

{
    NSString *_templetid;
    NSString *_medcid;
    NSString *_yongliang;
    NSString *_pinci;
    NSString *_days;
    NSString *_num;
    NSString *_yongfa;
    NSString *_zhutuo;
    
}

-(instancetype)initWithTempletid:(NSString *)templetid medcid:(NSString *)medcid yongliang:(NSString *)yongliang pinci:(NSString *)pinci days:(NSString *)days num:(NSString *)num yongfa:(NSString *)yongfa zhutuo:(NSString *)zhutuo
{
    
    self = [super init];
    if (self) {
        
        _templetid = templetid;
        _medcid = medcid;
        _yongliang = yongliang;
        _pinci = pinci;
        _days = days;
        _num = num;
        _yongfa = yongfa;
        _zhutuo = zhutuo;
        
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
    
    return @"/webservice/doctor.asmx/AddRecipeTempletChild";
}


-(id)requestArgument
{
    return @{
             @"templetid":_templetid,
             @"medcid":_medcid,
             @"yongliang":_yongliang,
             @"pinci":_pinci,
             @"days":_days,
             @"num":_num,
             @"yongfa":_yongfa,
             @"zhutuo":_zhutuo,
             
             };
    
}

@end
