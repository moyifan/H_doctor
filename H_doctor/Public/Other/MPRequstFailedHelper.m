





#import "MPRequstFailedHelper.h"

@implementation MPRequstFailedHelper

+(void)requstFailed:(YTKBaseRequest *)request
{
    if (request.responseStatusCode==401||request.responseStatusCode==407) {
        //清除操作
        
        
    }
    else
    {
        [MBProgressHUD showError:[NSString stringWithFormat:@"服务繁忙，请稍候重试(%ld)",(long)request.responseStatusCode] ToView:nil];
    }
}

@end
