//
//  ReceiveService.h
//  H_doctor
//
//  Created by zhiren on 2018/3/1.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface ReceiveService : BaseRequestService

-(instancetype)initWithDocid:(NSString *)docid dstid:(NSString *)dstid caseid:(NSString *)caseid;

@end
