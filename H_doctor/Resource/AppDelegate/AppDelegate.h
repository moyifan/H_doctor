//
//  AppDelegate.h
//  H_doctor
//
//  Created by zhiren on 2017/12/6.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 跳转首页
-(void)setUpHomeViewController;

// 跳转登录页
-(void)setupLoginViewController;

@end

