//
//  UploadSignImgService.h
//  H_doctor
//
//  Created by zhiren on 2018/2/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UploadSignImgService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid signimg:(UIImage *)signimg;

@end
