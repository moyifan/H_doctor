//
//  UpdateRecipeTempletChild_TempService.m
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "UpdateRecipeTempletChild_TempService.h"

@implementation UpdateRecipeTempletChild_TempService

{
    NSString *_docid;
    NSString *_medcid;
    NSString *_yongliang;
    NSString *_pinci;
    NSString *_days;
    NSString *_num;
    NSString *_yongfa;
    NSString *_zhutuo;
    NSString *_detailid;

}

-(instancetype)initWithDocid:(NSString *)docid detailid:(NSString *)detailid medcid:(NSString *)medcid yongliang:(NSString *)yongliang pinci:(NSString *)pinci days:(NSString *)days num:(NSString *)num yongfa:(NSString *)yongfa zhutuo:(NSString *)zhutuo{
    self = [super init];
    if (self) {
        
        _docid = docid;
        _medcid = medcid;
        _yongliang = yongliang;
        _pinci = pinci;
        _days = days;
        _num = num;
        _yongfa = yongfa;
        _zhutuo = zhutuo;
        _detailid = detailid;
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
    
    return @"/webservice/doctor.asmx/UpdateRecipeTempletChild_Temp";
}


-(id)requestArgument
{
    return @{
             @"docid":_docid,
             @"detailid":_detailid,
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
