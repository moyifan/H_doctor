//
//  UIButton+Line.h
//  gang
//
//  Created by zhiren on 16/9/14.
//  Copyright © 2016年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UIButton (Line)

@property (nonatomic) UIView *lineView;


// 创建下划线
-(void)creatLineView;
@end
