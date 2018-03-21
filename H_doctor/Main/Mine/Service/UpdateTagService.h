//
//  UpdateTagService.h
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateTagService : BaseRequestService

//修改职称
-(instancetype)initWithDocid:(NSString *)docid tagname:(NSString *)tagname;

@end
