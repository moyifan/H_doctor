//
//  UpdateGenderService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/13.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateGenderService : BaseRequestService

// 修改性别
-(instancetype)initWithDocid:(NSString *)docid gender:(NSString *)gender;

@end
