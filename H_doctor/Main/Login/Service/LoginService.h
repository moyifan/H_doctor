//
//  LoginService.h
//  H_doctor
//
//  Created by zhiren on 2018/1/15.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface LoginService : BaseRequestService

-(instancetype)initLoginWithPhoneNum:(NSString *)phoneNum passWord:(NSString *)passWord;;

@end
