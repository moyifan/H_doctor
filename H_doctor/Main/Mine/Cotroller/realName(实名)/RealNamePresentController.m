//
//  RealNamePresentController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/14.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "RealNamePresentController.h"

@interface RealNamePresentController ()

@end

@implementation RealNamePresentController

-(void)setNavBar
{
    [self.navigationView setTitle:@"实名认证"];
    
    MPWeakSelf(self)
    [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"close_icon_w"] clickCallBack:^(UIView *view) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGB(242, 246, 250);

    [self setNavBar];
    
    [self setupSubViews];

}


-(void)setupSubViews
{
    UIImageView *tip = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chenggongtijiao_icon"]];
    [tip sizeToFit];
    
    [self.view addSubview:tip];
    
    tip.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view, 252).widthIs(tip.width).heightIs(tip.height);
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = darkShenColor;
    tipLabel.font = PingFangFONT(16);
    tipLabel.text = @"您的资料已提交成功，请等待审核!";
    
    UILabel *tipDetailLabel = [[UILabel alloc] init];
    tipDetailLabel.textColor = darkQianColor;
    tipDetailLabel.font = PingFangFONT(16);
    tipDetailLabel.text = @"审核期通常在24小时以内";
    
    [self.view addSubview:tipLabel];
    [self.view addSubview:tipDetailLabel];
    
    tipLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(tip, 31).heightIs(tipLabel.font.lineHeight);
    [tipLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    tipDetailLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(tipLabel, 2).heightIs(tipDetailLabel.font.lineHeight);
    [tipDetailLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
}









@end
