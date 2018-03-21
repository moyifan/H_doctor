//
//  UploadCertService.h
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UploadCertService : BaseRequestService

// 职业认证
-(instancetype)initWithDocid:(NSString *)docid certcode:(NSString *)certcode certimg:(UIImage *)certimg;

@end
