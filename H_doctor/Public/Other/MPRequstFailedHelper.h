





// 统一处理网络请求失败时的内容

#import <Foundation/Foundation.h>
#import "YTKBaseRequest.h"

@interface MPRequstFailedHelper : NSObject

+(void)requstFailed:(YTKBaseRequest *)request;

@end
