//
//  UpdateRecipeTempletService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateRecipeTempletService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid ID:(NSString *)ID title:(NSString *)title sicknessid:(NSString *)sicknessid title_diy:(NSString *)title_diy;

@end
