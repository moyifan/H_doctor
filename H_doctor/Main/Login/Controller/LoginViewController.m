//
//  LoginViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/6.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginService.h"
#import "RegistViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@property (nonatomic,strong) UIImageView *backGroundView; //背景图
@property (nonatomic,strong) UITextField *phoneNum; //手机号

@property (nonatomic,strong) UITextField *passWord; // 密码
@property (nonatomic,strong) UIButton *loginBtn; // 登录按钮
@property (nonatomic,strong) UIButton *verificationButton; // 验证码按钮

@property (nonatomic,strong) UIButton *forgetPassWord; // 忘记密码
@property (nonatomic,strong) UIButton *regist; // 立即注册
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.navigationView setNavigationBackgroundAlpha:0];

    
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
    _passWord.placeholder = @"请输入密码";
//    _passWord.textAlignment = NSTextAlignmentCenter;
    _passWord.secureTextEntry = YES;
    
    [_backGroundView addSubview:_passWord];
    
    _passWord.sd_layout.topSpaceToView(_phoneNum,AdaptedWidth(35)).centerXEqualToView(_phoneNum).heightIs(AdaptedWidth(40)).widthIs(AdaptedWidth(300));
    
    // 创建分割线
    [_passWord creatLineView];
    
    
    
    
    
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
    
    
    
    // 忘记密码
    
    self.forgetPassWord = [[UIButton alloc] init];
    [_backGroundView addSubview:self.forgetPassWord];
    [_forgetPassWord setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetPassWord setTitleColor:darkzhongColor forState:UIControlStateNormal];
    _forgetPassWord.titleLabel.font = AdaptedFontSize(14);
    [_forgetPassWord addTarget:self action:@selector(didClickForgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [_forgetPassWord sizeToFit];
    
    _forgetPassWord.sd_layout.topSpaceToView(_loginBtn,AdaptedWidth(25)).leftSpaceToView(_backGroundView, AdaptedWidth(56)).widthIs(_forgetPassWord.width).heightIs(_forgetPassWord.height);
    
    
    
    //立即注册
    
    self.regist = [[UIButton alloc] init];
    [_backGroundView addSubview:self.regist];
    [_regist setTitle:@"立即注册" forState:UIControlStateNormal];
    [_regist setTitleColor:darkzhongColor forState:UIControlStateNormal];
    _regist.titleLabel.font = AdaptedFontSize(14);
    [_regist addTarget:self action:@selector(didClickRegist) forControlEvents:UIControlEventTouchUpInside];
    [_regist sizeToFit];
    
    _regist.sd_layout.topSpaceToView(_loginBtn,AdaptedWidth(25)).rightSpaceToView(_backGroundView, AdaptedWidth(56)).widthIs(_regist.width).heightIs(_regist.height);
    
}

// 退
-(void)didClickDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击登陆
-(void)didClickLogin
{
    
    if ([self.phoneNum.text isEqualToString:@""] || [self.passWord.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入完整信息" ToView:nil];
        return;
    }
    
    [MBProgressHUD showMessage:@"登录…" ToView:nil];

    
    
    LoginService *request = [[LoginService alloc] initLoginWithPhoneNum:self.phoneNum.text passWord:self.passWord.text];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request){
        NSLog(@"登录 %@ ",request.responseString);
        if ([request.responseJSONObject[@"code"] isEqual:@1]) {

            DoctorUserDefault.ID = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"docid"]];
            DoctorUserDefault.phoneNum = self.phoneNum.text;
            DoctorUserDefault.isLogin = YES;
            DoctorUserDefault.Token = request.responseJSONObject[@"token"];
        
            [[[NIMSDK sharedSDK] loginManager] login:DoctorUserDefault.ID token:DoctorUserDefault.Token completion:^(NSError * _Nullable error) {
                
                [MBProgressHUD hideHUD];
                if (!error) {
                    NSLog(@"登录成功");
                    //登录成功后跳转到首页
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    [[UserInfo shareUserInfo] updateUserInfo];

                    
                }else{
                    NSLog(@"登录失败 %@",error);
                    [MBProgressHUD showError:@"登录失败" ToView:nil];
                }
                
                
            }];
            
            
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:request.responseObject[@"msg"] ToView:nil];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络错误" ToView:nil];
        NSLog(@" %@",request.error);

    }];
    
    
}


// 忘记密码跳转
-(void)didClickForgetPassWord
{
    
    RegistViewController *regist = [[RegistViewController alloc] init];
    regist.Retitle = @"找回密码";
    [self.navigationController pushViewController:regist animated:YES];
    
}



// 注册跳转

-(void)didClickRegist
{
    RegistViewController *regist = [[RegistViewController alloc] init];
    regist.Retitle = @"注册";
    [self.navigationController pushViewController:regist animated:YES];
    
}











@end
