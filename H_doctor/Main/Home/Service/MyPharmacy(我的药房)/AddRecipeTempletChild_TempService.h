//
//  AddRecipeTempletChild_TempService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/15.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface AddRecipeTempletChild_TempService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid medcid:(NSString *)medcid yongliang:(NSString *)yongliang pinci:(NSString *)pinci days:(NSString *)days num:(NSString *)num yongfa:(NSString *)yongfa zhutuo:(NSString *)zhutuo; 

@end
