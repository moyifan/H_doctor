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



#import "PatientViewController.h"
#import "MineViewController.h"
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

    HomeViewController *home = [[HomeViewController alloc] init];
    EasyNavigationController *firstNav = [[EasyNavigationController alloc] initWithRootViewController:home];

    PatientViewController *patient = [[PatientViewController alloc] init];
    EasyNavigationController *secondNav = [[EasyNavigationController alloc] initWithRootViewController:patient];

    MineViewController *mine = [[MineViewController alloc] init];
    EasyNavigationController *thirdNav = [[EasyNavigationController alloc] initWithRootViewController:mine];

    
    NSArray *viewControllers = @[firstNav,
                                 secondNav,
                                 thirdNav,
                                 ];

    return viewControllers;

}




-(NSArray *)tabBarItemsAttributesForController
{

    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"shouye_icon",
                            CYLTabBarItemSelectedImage : @"shouye_n_icon",
                            };

    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"我的患者",
                            CYLTabBarItemImage : @"wodehuanzhe_icon",
                            CYLTabBarItemSelectedImage : @"wodehuanzhe_n_icon",
                            };
    
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"mine_icon",
                            CYLTabBarItemSelectedImage : @"mine_n_icon",
                            };
    
    
    NSArray *tabBarItemsAttributes = @[dict1,dict2,dict3];
    
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
