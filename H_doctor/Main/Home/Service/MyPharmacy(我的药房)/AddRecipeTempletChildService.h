//
//  AddRecipeTempletChildService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface AddRecipeTempletChildService : BaseRequestService

-(instancetype)initWithTempletid:(NSString *)templetid medcid:(NSString *)medcid yongliang:(NSString *)yongliang pinci:(NSString *)pinci days:(NSString *)days num:(NSString *)num yongfa:(NSString *)yongfa zhutuo:(NSString *)zhutuo; 
@end
