//
//Created by ESJsonFormatForMac on 18/02/12.
//

#import "UserInfo.h"
#import "GetUserInfo.h"

@implementation UserInfo

+(instancetype)shareUserInfo
{
    static UserInfo *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UserInfo alloc] init];
    });
    return userInfo;
}



-(instancetype)init
{
    if (self = [super init]) {
        
        self.model = [[UserInfoModel alloc] init];
    }
    
    return self;
}


-(void)updateUserInfo
{
    
    if ([DoctorUserDefault.ID isEqualToString:@"0"]) {
        return;
    }
    
    GetUserInfo *request = [[GetUserInfo alloc] initWithUserId:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"个人资料 %@",request.responseString);
        self.model = [UserInfoModel yy_modelWithJSON:request.responseJSONObject];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@" %@",request.error);
    }];
    
}



@end


