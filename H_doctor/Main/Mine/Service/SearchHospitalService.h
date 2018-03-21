//
//  SearchHospitalService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/13.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface SearchHospitalService : BaseRequestService

// 搜索医院
-(instancetype)initWithKeyword:(NSString *)keyword;

@end
