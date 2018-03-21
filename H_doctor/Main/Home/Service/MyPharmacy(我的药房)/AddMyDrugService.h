//
//  AddMyDrugService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/14.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface AddMyDrugService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid medcid:(NSString *)medcid;

@end
