//
//  ZJD_StarEvaluateView.m
//  KFXX
//
//  Created by aidong on 16/3/19.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "ZJD_StarEvaluateView.h"

@interface ZJD_StarEvaluateView ()
{
    
    NSInteger _totalStars;
}

@end

@implementation ZJD_StarEvaluateView

// 默认有五个星星
- (instancetype)initWithFrame:(CGRect)frame
                    starIndex:(NSInteger)index
                    starWidth:(CGFloat)starWidth
                        space:(CGFloat)space
                 defaultImage:(UIImage *)defaultImage
                   lightImage:(UIImage *)lightImage
                     isCanTap:(BOOL)isCanTap {
    
    return [self initWithFrame:frame totalStars:0 starIndex:index starWidth:starWidth space:space defaultImage:defaultImage lightImage:lightImage isCanTap:isCanTap];
}
// 自定义星星数量
- (instancetype)initWithFrame:(CGRect)frame
                   totalStars:(NSInteger)totalStars
                    starIndex:(NSInteger)index
                    starWidth:(CGFloat)starWidth
                        space:(CGFloat)space
                 defaultImage:(UIImage *)defaultImage
                   lightImage:(UIImage *)lightImage
                     isCanTap:(BOOL)isCanTap{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if (totalStars <= 0) {
            _totalStars = 5;
        } else {
            _totalStars = totalStars;
        }
        
        if (defaultImage) {
            self.defaultImage = defaultImage;
        } else {
            self.defaultImage = [UIImage imageNamed:@"big_stars"];
        }
        
        if (lightImage) {
            self.lightImage = lightImage;
        } else {
            self.lightImage = [UIImage imageNamed:@"big_stars_s"];
        }
        
        for (NSInteger j = 0; j < _totalStars; j++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(j* (starWidth + space), 0, starWidth, self.height)];
            
            btn.enabled = isCanTap;
            btn.tag = j + 1;
            [btn addTarget:self action:@selector(starTapBtn:) forControlEvents:UIControlEventTouchUpInside];
            // 上左下右 星星居中
            [btn setImageEdgeInsets:UIEdgeInsetsMake((self.height - starWidth)/2, 0, (self.height - starWidth)/2, 0)];
            if (j < index) {
                [btn setImage:self.lightImage forState:UIControlStateNormal];
            } else {
                [btn setImage:self.defaultImage forState:UIControlStateNormal];
            }
            [self addSubview:btn];
            
            // self.width
            self.width = (starWidth + space) * _totalStars;
        }
    }
    return self;
}

- (void)starTapBtn:(UIButton *)btn{
    
    for (NSInteger i = 1; i <= _totalStars; i++) {
        UIButton *starBtn = (UIButton *)[self viewWithTag:i];
        if (i <= btn.tag) {
            [starBtn setImage:self.lightImage forState:UIControlStateNormal];
        } else {
            [starBtn setImage:self.defaultImage forState:UIControlStateNormal];
        }
    }
    
    if (self.starEvaluateBlock) {
        self.starEvaluateBlock(self,btn.tag);
    }
}


-(void)setBtnIndex:(NSInteger )index
{

    for (NSInteger i = 1; i <= _totalStars; i++) {
        UIButton *starBtn = (UIButton *)[self viewWithTag:i];
        if (i <= index) {
            [starBtn setImage:self.lightImage forState:UIControlStateNormal];
        } else {
            [starBtn setImage:self.defaultImage forState:UIControlStateNormal];
        }
    }

}

@end

