//
//  UpdataNoteService.h
//  hospital
//
//  Created by zhiren on 2017/9/22.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface UpdataNoteService : BaseRequestService

-(instancetype)initUpdataNoteWithNoteId:(NSString *)noteId type:(NSString *)type accept:(NSString *)accept;

@end
