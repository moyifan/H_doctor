//
//  FindPassWordService.h
//  hospital
//
//  Created by zhiren on 2017/8/17.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface FindPassWordService : BaseRequestService

-(instancetype)initRegistWithPhoneNum:(NSString *)phoneNum verificationCode:(NSString *)verificationCode passWord:(NSString *)passWord;
@end
