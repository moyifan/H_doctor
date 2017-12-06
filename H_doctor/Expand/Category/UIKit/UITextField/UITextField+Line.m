//
//  UITextField+Line.m
//  gang
//
//  Created by zhiren on 16/8/29.
//  Copyright © 2016年 zhiren. All rights reserved.
//

#import "UITextField+Line.h"

#define lineColor RGB(228, 228, 228)

@implementation UITextField (Line)





-(void)creatLineView
{

    UIView *lineView = [[UIView alloc] init];

    lineView.backgroundColor= lineColor;
    
    [self addSubview:lineView];

    lineView.sd_layout.leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightIs(0.5);

}


@end
