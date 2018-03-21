//
//  UpdateSectionService.h
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateSectionService : BaseRequestService

// 修改科室
-(instancetype)initWithDocid:(NSString *)docid sectionid:(NSString *)sectionid;

@end
