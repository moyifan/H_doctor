//
//  GVUserDefaults+BBProperties.h
//  GrowthDiary
//
//  Created by wujunyang on 16/1/5.
//  Copyright (c) 2016年 wujunyang. All rights reserved.
//

#import "GVUserDefaults.h"

#define DoctorUserDefault [GVUserDefaults standardUserDefaults]

typedef NS_ENUM(NSUInteger, LineState) {
    askLine = 0,
    videoLine = 1,
};


@interface GVUserDefaults (BBProperties)

#pragma mark -- personinfo
//@property (nonatomic,weak) NSString *userName;
//@property (nonatomic,weak) NSString *name;

@property (nonatomic,weak) NSString *phoneNum;

@property (nonatomic,weak) NSString *ID;
@property (nonatomic,weak) NSString *nickName;
@property (nonatomic,weak) NSString *icon;
@property (nonatomic,weak) NSString *loginType;
@property (nonatomic,assign) NSInteger shoppingCount;


@property (nonatomic,weak) NSString *Token;

@property (nonatomic,assign) LineState lineType; // 问诊类型
@property (nonatomic,weak) NSString *doctorID; // 医生id
@property (nonatomic,weak) NSString *payMent; // 医生价格



#pragma mark --是否是第一次启动APP程序
@property (nonatomic,assign) BOOL isNoFirstLaunch;

// 是否登录
@property (nonatomic,assign) BOOL isLogin;




// 查询信息
@property (nonatomic,weak) NSString *out_trade_no;
@property (nonatomic,weak) NSString *nonce_str;
@property (nonatomic,weak) NSString *product_id;
@property (nonatomic,weak) NSString *payDoctorName;
@property (nonatomic,assign) NSInteger product_type;



@end
