//
//  UIButton+Line.m
//  gang
//
//  Created by zhiren on 16/9/14.
//  Copyright © 2016年 zhiren. All rights reserved.
//

#import "UIButton+Line.h"

@interface UIButton ()



@end

const void *key = @"lineView";

@implementation UIButton (Line)


-(void)setLineView:(UIView *)lineView
{
    objc_setAssociatedObject(self, key, lineView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(UIView *)lineView
{

    return objc_getAssociatedObject(self, key);
}


-(void)creatLineView
{
    
    UIView *lineView = [[UIView alloc] init];
    
    lineView.backgroundColor= blueBG;
    self.lineView = lineView;
    
    [self addSubview:lineView];
    
    lineView.sd_layout.leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightIs(1);

    
}

@end
