//
//  UpdateHospitalService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/13.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateHospitalService : BaseRequestService

// 修改医院
-(instancetype)initWithDocid:(NSString *)docid hosptlid:(NSString *)hosptlid;

@end
