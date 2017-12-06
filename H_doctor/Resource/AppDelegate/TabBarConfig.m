//
//  TabBarConfig.m
//  hospital
//
//  Created by zhiren on 2017/6/29.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "TabBarConfig.h"


@interface BaseNavigationController : UINavigationController

@end
@implementation BaseNavigationController

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    UIImage *bgimage = [UIImage imageNamed:@"topback_icon"];
//    [self.navigationController.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
//
//    
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        //第二级则隐藏底部Tab
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end



#import "AskHomeViewController.h"
#import "ShoppingHomeViewController.h"
#import "HealthyHomeViewController.h"
#import "MineHomeViewController.h"
#import "HomeViewController.h"

@interface TabBarConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end


@implementation TabBarConfig


- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
     
        
        
    }
    return _tabBarController;
}





- (NSArray *)viewControllers {

    AskHomeViewController *ask = [[AskHomeViewController alloc] init];
    BaseNavigationController *firstNav = [[BaseNavigationController alloc] initWithRootViewController:ask];
    
    ShoppingHomeViewController *shopping = [[ShoppingHomeViewController alloc] init];
    BaseNavigationController *secondNav = [[BaseNavigationController alloc] initWithRootViewController:shopping];
    
//    HomeViewController *home = [[HomeViewController alloc] init];
//    BaseNavigationController *thirdNav = [[BaseNavigationController alloc] initWithRootViewController:home];
    
    HealthyHomeViewController *healthy = [[HealthyHomeViewController alloc] init];
    BaseNavigationController *thirdNav = [[BaseNavigationController alloc] initWithRootViewController:healthy];
    
    MineHomeViewController *mine = [[MineHomeViewController alloc] init];
    BaseNavigationController *fourthlyNav = [[BaseNavigationController alloc] initWithRootViewController:mine];

    NSArray *viewControllers = @[firstNav,
                                 secondNav,
                                 thirdNav,
                                 fourthlyNav
//                                 fiveNav
                                 ];

    
    return viewControllers;

}




-(NSArray *)tabBarItemsAttributesForController
{

    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"在线问诊",
                            CYLTabBarItemImage : @"zhenduan_icon",
                            CYLTabBarItemSelectedImage : @"zhenduan_icon_n",
                            };
    
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"药品商城",
                            CYLTabBarItemImage : @"gouwuche_icon",
                            CYLTabBarItemSelectedImage : @"gouwuche_icon_n",
                            };
    
//    NSDictionary *dict3 = @{
//                            CYLTabBarItemTitle : @"首页",
//                            CYLTabBarItemImage : @"home",
//                            CYLTabBarItemSelectedImage : @"home_s",
//                            };
    
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"健康管理",
                            CYLTabBarItemImage : @"benzi_icon",
                            CYLTabBarItemSelectedImage : @"benzi_icon_n",
                            };
    
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"mine_icon",
                            CYLTabBarItemSelectedImage : @"mine_icon_n",
                            };
    
    
    
    NSArray *tabBarItemsAttributes = @[dict1,dict2,dict3,dict4];
    
    return tabBarItemsAttributes;

}


- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {


    // 此处将tabbar的半透明属性改为No
    tabBarController.tabBar.translucent = NO;
    
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = darkQianColor;
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = RGB(71, 148, 245);
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    


    // 背景色
//    tabBarController.tabBar.barTintColor = RGB(240, 237, 229);
    
    // TabBarItem选中后的背景颜色
//    [self customizeTabBarSelectionIndicatorImage];

}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:RGB(188, 159, 124)
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
