//
//  YJBezierPath.h
//  TestOC
//
//  Created by 李亚军 on 2017/2/8.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BezierPath : UIBezierPath

//画笔的颜色
@property (nonatomic,copy) UIColor *lineColor;
//是否是橡皮擦
@property (nonatomic,assign) BOOL isErase;

@end
