//
//  AppDelegate.m
//  H_doctor
//
//  Created by zhiren on 2017/12/6.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarConfig.h"
#import "LoginViewController.h"
#import "YTKNetworkConfig.h"

#import "ChatSocketCline.h"

@import SocketIO;

@interface AppDelegate ()

@property (nonatomic,strong) LoginViewController *loginVC;
@property (nonatomic,strong) TabBarConfig *tabBarConfig;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    //键盘统一收回处理
    [self configureBoardManager];
    
    // 网络初始化
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = @"http://smx.hnshlwyy.com/";
    config.baseUrl = @"http://192.168.10.131";

    
    // 导航栏
    [self setNavBarAppearence];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    
    //云信
    [self setupNIMSDK];
    
    // socket
    [self setupSocket];

    
    [self setUpHomeViewController];

    if (DoctorUserDefault.isLogin) {
    
        [[[NIMSDK sharedSDK] loginManager] login:DoctorUserDefault.ID token:DoctorUserDefault.Token completion:^(NSError * _Nullable error) {

            if (!error) {
                NSLog(@"登录成功 %@",DoctorUserDefault.ID);

                [[UserInfo shareUserInfo] updateUserInfo];

            }else{
                NSLog(@"登录失败 %@",error);
                DoctorUserDefault.isLogin = NO;
                [self setupLoginViewController];
                [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error){}];
                [[ChatSocketCline shareSocketCline] disconnect];

            }

        }];
        
    
    }else{
        [self setupLoginViewController];
        DoctorUserDefault.ID = @"0";
    }

    
  
    
    
    return YES;
}




-(void)setupNIMSDK
{
    
    //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
    //    self.sdkConfigDelegate = [[NTESSDKConfigDelegate alloc] init];
    //    [[NIMSDKConfig sharedConfig] setDelegate:self.sdkConfigDelegate];
    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
    [[NIMSDKConfig sharedConfig] setEnabledHttpsForInfo:NO];
    
    
    [[NIMSDK sharedSDK] registerWithAppID:kyunAppKey
                                  cerName:@""];
    
    
//    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
//    [[NIMSDK sharedSDK].loginManager addDelegate:self];
//    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    
    
}



-(void)setupSocket
{
    SocketIOClient *socket = [ChatSocketCline shareSocketCline];
    
    [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket 连接成功");
    }];
    
    [socket on:@"disconnect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket 断开");
    }];
    
    
    [socket connectWithTimeoutAfter:5 withHandler:^{
        NSLog(@"连接超时");
    }];
    
}



#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;                       // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES;   // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;  // 控制键盘上的工具条文字颜色是否用户自定义
    manager.keyboardDistanceFromTextField=60;   // 键盘设置距离文本框使用
    manager.enableAutoToolbar = NO;             // 控制是否显示键盘上的工具条
    
}


- (void)setNavBarAppearence
{
    EasyNavigationOptions *options = [EasyNavigationOptions shareInstance];
    options.titleColor = [UIColor whiteColor];
    options.titleFont = PingFangFONT(18);
    options.buttonTitleFont = PingFangFONT(16);
    options.buttonTitleColor = [UIColor whiteColor];
    options.navBackgroundImage = [UIImage imageNamed:@"bg_na"];
    options.navigationBackButtonImage = [UIImage imageNamed:@"back_"];

    
//    EasyNavigationView
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;


}



#pragma mark 自定义跳转不同的页面
//登录页面
-(void)setupLoginViewController
{
    [self.window endEditing:YES];
    
    EasyNavigationController *nav = [[EasyNavigationController alloc]initWithRootViewController:self.loginVC];
    [self.tabBarConfig.tabBarController.selectedViewController presentViewController:nav animated:YES completion:nil];
    
//    [self.tabBarConfig.tabBarController.selectedViewController presentViewController:self.loginVC animated:YES completion:nil];
    
    
}

-(void)setUpHomeViewController
{
    [MBProgressHUD hideHUD];
    
    
    [self.window setRootViewController:self.tabBarConfig.tabBarController];
     
    [self.window makeKeyAndVisible];
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark 懒加载

-(LoginViewController *)loginVC
{
    if (!_loginVC) {
        
        _loginVC = [[LoginViewController alloc]init];
        
    }
    return _loginVC;
}



-(TabBarConfig *)tabBarConfig
{
    if (!_tabBarConfig) {
        
        _tabBarConfig = [[TabBarConfig alloc] init];
        
    }
    
    return _tabBarConfig;
}



@end
