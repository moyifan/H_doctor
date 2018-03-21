//
//  UpdateRealNameService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateRealNameService : BaseRequestService

// 修改名字
-(instancetype)initWithDocid:(NSString *)docid realname:(NSString *)realname;

@end
