//
//  ChangePhoneViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/22.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()
@property (nonatomic,strong) UITextField *phoneNum; //手机号
@property (nonatomic,strong) UITextField *passWord; // 密码
@property (nonatomic,strong) UIButton *verificationButton; // 验证码按钮

@end


@implementation ChangePhoneViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"更改手机号"];
    
    MPWeakSelf(self)
    [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationView addRightButtonWithTitle:@"提交" clickCallBack:^(UIView *view) {
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
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
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    
    
    UIView *passwordView = [[UIView alloc] init];
    passwordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordView];
    
    
    // 手机号
    self.phoneNum = [[UITextField alloc] init];
    _phoneNum.font = PingFangFONT(16);
    _phoneNum.textColor = darkShenColor;
    _phoneNum.placeholder = @"请输入新手机号";
    _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    [phoneView addSubview:_phoneNum];
    
    
    // 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(239, 239, 239);
    [self.view addSubview:line];
    
    
    
    // 验证码按钮
    self.verificationButton = [[UIButton alloc] init];
    [_verificationButton setBackgroundImage:[UIImage imageNamed:@"code_icon"] forState:UIControlStateNormal];
    [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verificationButton.titleLabel.font = PingFangFONT(14);
    [_verificationButton setTitleColor:RGB(72, 147, 245) forState:UIControlStateNormal];
    [_verificationButton addTarget:self action:@selector(didClickVerificationBtn) forControlEvents:UIControlEventTouchUpInside];
    [_verificationButton sizeToFit];
    
    [passwordView addSubview:_verificationButton];
    
    
    
    self.passWord = [[UITextField alloc] init];
    _passWord.font = PingFangFONT(16);
    _passWord.placeholder = @"请输入短信验证码";
    _passWord.secureTextEntry = YES;
    [passwordView addSubview:_passWord];

    
   
    
    
    phoneView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 10+64).heightIs(44);
    
    line.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(phoneView, 0).heightIs(1);
    
    passwordView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(line, 0).heightIs(44);
    
    
    _phoneNum.sd_layout.leftSpaceToView(phoneView, 16).rightSpaceToView(phoneView, 16).centerYEqualToView(phoneView).heightIs(_phoneNum.font.lineHeight);
    
    
    _verificationButton.sd_layout.rightSpaceToView(passwordView, 15).centerYEqualToView(passwordView).widthIs(_verificationButton.width).heightIs(_verificationButton.height);
    
    
    _passWord.sd_layout.leftSpaceToView(passwordView, 16).rightSpaceToView(_verificationButton, 16).centerYEqualToView(passwordView).heightIs(_passWord.font.lineHeight);

}




// 点击获取验证码
-(void)didClickVerificationBtn
{
    
    //    if ([self.Gtype isEqualToString:@"注册"]) {
    //
    //        [self getVerificationCode];
    //    }else{
    //        [self getVerificationCodeReset];
    //    }
    
    
    [self timeout];
    
}



#pragma mark --- 点击验证码后的倒计时
-(void)timeout
{
    __block int timeout= 59; //倒计时时间
    //点击获取验证码后,进行倒计时
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.verificationButton.userInteractionEnabled = YES;
                //设置界面的按钮显示 根据自己需求设置
                [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_verificationButton setTitleColor:RGB(72, 147, 245) forState:UIControlStateNormal];
                
                
                
            });
            
        }else {
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.verificationButton.userInteractionEnabled = NO;
                
                //设置界面的按钮显示 根据自己需求设置
                [_verificationButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [_verificationButton setBackgroundImage:[UIImage imageNamed:@"code_icon_disable"] forState:UIControlStateNormal];
                [_verificationButton setTitleColor:darkQianColor forState:UIControlStateNormal];
                
                
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(timer);
    
    
}










@end
