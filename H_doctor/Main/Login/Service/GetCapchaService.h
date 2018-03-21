//
//  GetCapchaService.h
//  hospital
//
//  Created by zhiren on 2017/8/15.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface GetCapchaService : BaseRequestService

-(instancetype)initRegistWithPhoneNum:(NSString *)phoneNum;

@end
