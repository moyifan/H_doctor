//
//  UpdatePermitService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdatePermitService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid status:(NSString *)status who:(NSString *)who;

@end
