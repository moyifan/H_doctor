//
//  DeleteRecipeTemplateService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/15.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface DeleteRecipeTemplateService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid detailid:(NSString *)detailid;

@end
