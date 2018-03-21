//
//  UpdateExpertiseService.h
//  H_doctor
//
//  Created by zhiren on 2018/2/26.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateExpertiseService : BaseRequestService

//修改擅长
-(instancetype)initWithDocid:(NSString *)docid expertise:(NSString *)expertise;

@end
