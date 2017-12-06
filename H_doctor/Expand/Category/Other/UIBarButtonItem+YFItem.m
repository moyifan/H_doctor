//
//  UIBarButtonItem+YFItem.m
//  weibo
//
//  Created by moyifan on 15/3/24.
//  Copyright (c) 2015年 moyifan. All rights reserved.
//

#import "UIBarButtonItem+YFItem.h"

@implementation UIBarButtonItem (YFItem)



+(UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+(UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}



+(UIBarButtonItem *)itemWithIcon:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
//    if (IPHONE6P) {
//        
//        btn.width = 60;
//        btn.height = 60;
//        
//        btn.imageView.layer.cornerRadius = 30;
//        btn.imageView.layer.masksToBounds = YES;
//    
//    }else{
    
        btn.width = 40;
        btn.height = 40;
        
        btn.imageView.layer.cornerRadius = 20;
        btn.imageView.layer.masksToBounds = YES;
    
//    }
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];



}








@end
