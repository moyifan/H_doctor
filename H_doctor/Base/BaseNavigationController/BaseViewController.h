//
//  ViewController.m
//  VR
//
//  Created by zhiren on 16/7/12.
//  Copyright © 2016年 zhiren. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "UIImage+Color.h"

@protocol  BBBaseViewControllerDataSource<NSObject>

-(NSMutableAttributedString*)setTitle;
-(UIButton*)set_leftButton;
-(UIButton*)set_rightButton;
-(UIColor*)set_colorBackground;

-(CGFloat)set_navigationHeight;
-(UIView*)set_bottomView;
-(UIImage*)navBackgroundImage;
-(BOOL)hideNavigationBottomLine;
-(UIImage*)set_leftBarButtonItemWithImage;
-(UIImage*)set_rightBarButtonItemWithImage;

@end


@protocol BBBaseViewControllerDelegate <NSObject>

@optional

-(void)left_button_event:(UIButton*)sender;
-(void)right_button_event:(UIButton*)sender;
-(void)title_click_event:(UIView*)sender;

@end


@interface BaseViewController : UIViewController<BBBaseViewControllerDataSource , BBBaseViewControllerDelegate>

// 改变导航栏达到隐藏目的
-(void)changeNavigationBarTranslationY:(CGFloat)translationY;

-(void)set_Title:(NSMutableAttributedString *)title;



@end
