//
//Created by ESJsonFormatForMac on 18/02/12.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserInfo : NSObject

@property (nonatomic,strong) UserInfoModel *model;

+(instancetype)shareUserInfo;

-(void)updateUserInfo;

@end

