//
//  GetRecipeTempletService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface GetRecipeTempletService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid type:(NSString *)type;

@end
