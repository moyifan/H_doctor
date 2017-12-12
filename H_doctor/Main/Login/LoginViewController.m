//
//  LoginViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/6.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic,strong) UIImageView *backGroundView; //背景图
@property (nonatomic,strong) UITextField *phoneNum; //手机号

@property (nonatomic,strong) UITextField *passWord; // 密码
@property (nonatomic,strong) UIButton *loginBtn; // 登录按钮
@property (nonatomic,strong) UIButton *verificationButton; // 验证码按钮


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.backGroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_icon"]];
    _backGroundView.frame = self.view.frame;
    _backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:_backGroundView];
    
    [self setupSubviews];
    
}


-(void)setupSubviews
{
    
    // 退出按钮
    UIButton *dismiss = [[UIButton alloc] init];
    [dismiss setBackgroundImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
    [dismiss sizeToFit];
    [dismiss addTarget:self action:@selector(didClickDismiss) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundView addSubview:dismiss];
    dismiss.sd_layout.leftSpaceToView(_backGroundView, 30).topSpaceToView(_backGroundView, 30).widthIs(dismiss.width).heightIs(dismiss.height);
    
    
    
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_icon"]];
    [logo sizeToFit];
    
    [_backGroundView addSubview:logo];
    
    logo.sd_layout.centerXEqualToView(_backGroundView).topSpaceToView(_backGroundView, 136).widthIs(logo.width).heightIs(logo.height);
    
    
    
    // 手机号
    self.phoneNum = [[UITextField alloc] init];
    _phoneNum.font = PingFangFONT(16);
    _phoneNum.placeholder = @"请输入手机号";
//    _phoneNum.textAlignment = NSTextAlignmentCenter;
    //    _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    if (![DoctorUserDefault.phoneNum isEqualToString:@""]) {
        
        _phoneNum.text = DoctorUserDefault.phoneNum;
    }
    
    [_backGroundView addSubview:_phoneNum];
 _phoneNum.sd_layout.topSpaceToView(logo,AdaptedWidth(78)).centerXEqualToView(_backGroundView).heightIs(AdaptedWidth(40)).widthIs(AdaptedWidth(300));
    
    // 创建分割线
    [_phoneNum creatLineView];
    
    
    
    
    // 密码
    self.passWord = [[UITextField alloc] init];
    _passWord.font = PingFangFONT(16);
    _passWord.placeholder = @"请输入验证码";
//    _passWord.textAlignment = NSTextAlignmentCenter;
    _passWord.secureTextEntry = YES;
    
    [_backGroundView addSubview:_passWord];
    
    _passWord.sd_layout.topSpaceToView(_phoneNum,AdaptedWidth(35)).centerXEqualToView(_phoneNum).heightIs(AdaptedWidth(40)).widthIs(AdaptedWidth(300));
    
    // 创建分割线
    [_passWord creatLineView];
    
    
    
    
    // 验证码按钮
    self.verificationButton = [[UIButton alloc] init];
    [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verificationButton.titleLabel.font = PingFangFONT(16);
    [_verificationButton setTitleColor:RGB(56, 102, 173) forState:UIControlStateNormal];
    [_verificationButton addTarget:self action:@selector(didClickVerificationBtn) forControlEvents:UIControlEventTouchUpInside];
    [_verificationButton sizeToFit];
    
    [_backGroundView addSubview:_verificationButton];

    _verificationButton.sd_layout.bottomEqualToView(_passWord).rightSpaceToView(_backGroundView,60).widthIs(_verificationButton.width).heightIs(_verificationButton.height);
    
    
    
    
    
    //登录按钮
    
    UIButton *loginBtn = [[UIButton alloc] init];
    _loginBtn = loginBtn;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = PingFangFONT(18);
    [loginBtn addTarget:self action:@selector(didClickLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [_backGroundView addSubview:loginBtn];
    
    loginBtn.sd_layout.centerXEqualToView(_backGroundView).topSpaceToView(_passWord, 60).widthIs(300).heightIs(44);
    
}

// 退
-(void)didClickDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击登陆
-(void)didClickLogin
{
    
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
                [_verificationButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [_verificationButton setTitleColor:RGB(56, 102, 173) forState:UIControlStateNormal];
                
                
                
            });
            
        }else {
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.verificationButton.userInteractionEnabled = NO;

                //设置界面的按钮显示 根据自己需求设置
                [_verificationButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [_verificationButton setTitleColor:darkQianColor forState:UIControlStateNormal];
                
                
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(timer);
    
    
}







@end
