//
//  GetPatientInfoService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/20.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface GetPatientInfoService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid;

@end
