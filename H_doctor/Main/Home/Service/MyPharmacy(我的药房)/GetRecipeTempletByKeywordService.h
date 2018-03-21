//
//  GetRecipeTempletByKeywordService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface GetRecipeTempletByKeywordService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid type:(NSString *)type keyword:(NSString *)keyword;

@end
