//
//  UpdateUserIcon.h
//  H_doctor
//
//  Created by zhiren on 2018/2/23.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdateUserIcon : BaseRequestService

-(instancetype)initWithDocid:(NSString *)doc Img:(UIImage *)img;

@end
