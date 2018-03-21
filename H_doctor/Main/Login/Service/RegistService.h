//
//  RegistService.h
//  hospital
//
//  Created by zhiren on 2017/8/15.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface RegistService : BaseRequestService

-(instancetype)initRegistWithPhoneNum:(NSString *)phoneNum verificationCode:(NSString *)verificationCode passWord:(NSString *)passWord;


@end
