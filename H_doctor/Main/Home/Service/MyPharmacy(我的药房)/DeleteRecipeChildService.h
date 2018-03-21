//
//  DeleteRecipeChildService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface DeleteRecipeChildService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid detailid:(NSString *)detailid;

@end
