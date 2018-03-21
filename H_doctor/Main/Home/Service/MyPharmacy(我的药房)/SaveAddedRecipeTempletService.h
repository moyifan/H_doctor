//
//  SaveAddedRecipeTempletService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface SaveAddedRecipeTempletService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid title:(NSString *)title sicknessid:(NSString *)sicknessid title_diy:(NSString *)title_diy;

@end
