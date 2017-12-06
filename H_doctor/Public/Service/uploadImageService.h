//
//  uploadImageService.h
//  gang
//
//  Created by zhiren on 2016/10/14.
//  Copyright © 2016年 zhiren. All rights reserved.
//

#import "BaseRequestService.h"

@interface uploadImageService : BaseRequestService

-(instancetype)initWithUploadAndImagePath:(UIImage *)Path;

- (NSString *)responseData;

@end
