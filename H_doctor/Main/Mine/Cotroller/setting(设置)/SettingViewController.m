//
//  SettingViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/22.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "SettingViewController.h"
#import "WRCellView.h"
#import "ChangePhoneViewController.h"
#import "AppDelegate.h"
#import "ChatSocketCline.h"

@interface SettingViewController ()
@property (nonatomic, strong) WRCellView *changePhone;

@end

@implementation SettingViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"设置"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(242, 246, 250);

    [self setNavBar];
    
    [self setupSubviews];
    
    [self onClickEvent];
}


-(void)setupSubviews
{
    [self.view addSubview:self.changePhone];
    
    self.changePhone.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 11+64).heightIs(44);
    
    
    
    // 退出
    UIButton *close = [[UIButton alloc] init];
    
    [close setBackgroundColor:[UIColor whiteColor]];
    [close setTitle:@"退出当前账户" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    close.titleLabel.font = AdaptedFontSize(16);
    [close addTarget:self action:@selector(didClickdisLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:close];
    
    close.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view,50).heightIs(44);
    
    
}


- (void)onClickEvent
{
    __weak typeof(self) weakSelf = self;
    self.changePhone.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        ChangePhoneViewController *change = [[ChangePhoneViewController alloc] init];
        [pThis.navigationController pushViewController:change animated:YES];
    };

}



// 点击退出登录
-(void)didClickdisLogin
{
    if (DoctorUserDefault.isLogin) {
        
        DoctorUserDefault.isLogin = NO;
        DoctorUserDefault.ID = @"0";
        [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error){}];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[ChatSocketCline shareSocketCline] disconnect];
        
    }else{
        
        [((AppDelegate *)AppDelegateInstance) setupLoginViewController];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}



#pragma mark 懒加载

-(WRCellView *)changePhone
{
    
    if (!_changePhone) {
        
        _changePhone = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _changePhone.leftLabel.text = @"更换手机号";
        [_changePhone setHideBottomLine:YES];
        
    }
    
    return _changePhone;
    
}

@end
