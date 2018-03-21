//
//  UploadIDCard.h
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UploadIDCard : BaseRequestService

//实名认证
-(instancetype)initWithDocid:(NSString *)docid front:(UIImage *)front back:(UIImage *)back;

@end
