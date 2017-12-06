//
//  ThirdMacros.h
//  MobileProject 第三方SDK的Key及配置
//
//  Created by zhiren on 16/8/2.
//  Copyright © 2016年 zhiren. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h


// 网易云信
#define kyunAppKey @"a75f33782cc86bb776d97d5ae2d7a2f8"
#define Message_Font_Size   14        // 普通聊天文字大小
#define Notification_Font_Size   10   // 通知文字大小
#define Chatroom_Message_Font_Size 16 // 聊天室聊天文字大小
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
#define UISreenWidthScale   Main_Screen_Width / 320



//百度地图SDK的Key
#define  kBaiduMapKey @""

//友盟SDK的key
#define kUmengKey @"581be8abc62dca453b0012ea"

//友盟分享
//--微信
#define kSocial_WX_ID @"wxa7188aba30f13787" //开户邮件中的（公众账号APPID或者应用APPID）
#define kSocial_WX_Secret @"e13dde3c655f75982946e828d4127401"
#define kSocial_WX_Url @"http://baidu.com"
//微信支付商户号
#define MCH_ID  @"1489276812"
//安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @"RLyO1GZ3UN8iIhehGc6KLEJAqEeErn12"
//获取用户openid，可使用APPID对应的公众平台登录http://mp.weixin.qq.com 的开发者中心获取AppSecret。
#define WX_AppSecret @"e13dde3c655f75982946e828d4127401"


//--QQ
#define kSocial_QQ_ID  @"1105820593"
#define kSocial_QQ_Secret @"qMzUAMzRHjyFwtej"
#define kSocial_QQ_Url @""
//--新浪微博
#define kSocial_Sina_Account @"1753888230"
#define kSocial_Sina_RedirectURL @"efba7d9e9988e280f2b6139b8d774123"





/**
 -----------------------------------
 统一下单请求参数键值
 -----------------------------------
 */

#define WXAPPID         @"appid"            // 应用id
#define WXMCHID         @"mch_id"           // 商户号
#define WXNONCESTR      @"nonce_str"        // 随机字符串
#define WXSIGN          @"sign"             // 签名
#define WXBODY          @"body"             // 商品描述
#define WXOUTTRADENO    @"out_trade_no"     // 商户订单号
#define WXTOTALFEE      @"total_fee"        // 总金额
#define WXEQUIPMENTIP   @"spbill_create_ip" // 终端IP
#define WXNOTIFYURL     @"notify_url"       // 通知地址
#define WXTRADETYPE     @"trade_type"       // 交易类型
#define WXPREPAYID      @"prepay_id"        // 预支付交易会话



#endif /* ThirdMacros_h */
