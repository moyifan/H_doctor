//
//  UserInfoModel.h
//  H_doctor
//
//  Created by zhiren on 2018/2/11.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Doc;
@interface UserInfoModel : NSObject

@property (nonatomic, strong) Doc *doc;

@property (nonatomic, assign) NSInteger code;

@end

@interface Doc : NSObject

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *signimg;

@property (nonatomic, copy) NSString *govname;

@property (nonatomic, copy) NSString *sectionname;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *realname;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *expertise;

@property (nonatomic, copy) NSString *certcode;

@property (nonatomic, assign) BOOL isaudit;  // 实名认证

@property (nonatomic, assign) BOOL certaudit; // 职业认证

@property (nonatomic, copy) NSString *amount; // 收入

@property (nonatomic, assign) NSInteger sectionid; // 科室id

@property (nonatomic, assign) NSInteger hospitalid; 

@end

