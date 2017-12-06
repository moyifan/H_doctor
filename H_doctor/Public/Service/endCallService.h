//
//  endCallService.h
//  hospital
//
//  Created by zhiren on 2017/9/27.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface endCallService : BaseRequestService

-(instancetype)initEndCallWithNoteId:(NSString *)noteId;

@end
