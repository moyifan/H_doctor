//
//  GetVerificationViewController.m
//  hospital
//
//  Created by zhiren on 2017/7/4.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "GetVerificationViewController.h"
#import "GetCapchaService.h"
#import "RegistService.h"
#import "FindPassWordService.h"

@interface GetVerificationViewController ()
@property (nonatomic,strong) UITextField *verification; //验证码
@property (nonatomic,strong) UIButton *verificationButton; // 验证码按钮

@property (nonatomic,strong) UIButton *nextBtn; // 下一步

@end

@implementation GetVerificationViewController


-(void)setNavBar
{
    [self.navigationView setTitle:@"手机号验证"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    
    
    [self setupSubviews];


}


-(void)setupSubviews
{

    // 验证码
    _verification = [[UITextField alloc] init];
    _verification.font = PingFangFONT(15);
    _verification.placeholder = @"请输入验证码";
    _verification.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_verification];
    
    _verification.sd_layout.topSpaceToView(self.view,15+64).centerXEqualToView(self.view).heightIs(40).widthIs(345);
    
    // 创建分割线
    [_verification creatLineView];
    
    
    
    // 验证码按钮
    self.verificationButton = [[UIButton alloc] init];
    [self.view addSubview:_verificationButton];
    [_verificationButton setTitle:@"重新发送" forState:UIControlStateNormal];
    _verificationButton.titleLabel.font = PingFangFONT(14);
    [_verificationButton setTitleColor:RGB(56, 102, 173) forState:UIControlStateNormal];
    [_verificationButton addTarget:self action:@selector(didClickVerificationBtn) forControlEvents:UIControlEventTouchUpInside];
    [_verificationButton sizeToFit];
    _verificationButton.sd_layout.bottomEqualToView(_verification).rightSpaceToView(self.view,23).widthIs(_verificationButton.width).heightIs(_verificationButton.height);
    
    
    [self didClickVerificationBtn];
    
    
    
    
    // 下一步
    _nextBtn = [[UIButton alloc] init];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"anjian_icon"] forState:UIControlStateNormal];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = PingFangFONT(17);
    [_nextBtn addTarget:self action:@selector(didClickNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nextBtn];
    
    _nextBtn.sd_layout.centerXEqualToView(self.view).topSpaceToView(_verification, 50).widthIs(345).heightIs(50);

    
}



// 点击获取验证码
-(void)didClickVerificationBtn
{
    
    [self getVerificationCode];
 
    
    [self timeout];

}


// 点击下一步
-(void)didClickNext
{
    
    if ([self.Gtype isEqualToString:@"注册"]) {
        
        [self regist];
    }else{
        [self findPassword];
    }

    
}


-(void)findPassword
{

    FindPassWordService *request = [[FindPassWordService alloc] initRegistWithPhoneNum:self.phoneNo verificationCode:_verification.text passWord:self.password];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [MBProgressHUD hideHUD];
        //        NSLog(@" %@",request.responseJSONObject);
        if ([request.responseJSONObject[@"errcode"] isEqual:@0]) {
            
            [MBProgressHUD showSuccess:@"修改成功" ToView:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            
            [MBProgressHUD showError:request.responseJSONObject[@"errmsg"] ToView:nil];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
//        [MBProgressHUD showError:@"网络错误" ToView:nil];
    }];
    

}


-(void)regist
{

    RegistService *request = [[RegistService alloc] initRegistWithPhoneNum:self.phoneNo verificationCode:_verification.text passWord:self.password];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [MBProgressHUD hideHUD];
        //        NSLog(@" %@",request.responseJSONObject);
        if ([request.responseJSONObject[@"errcode"] isEqual:@0]) {
            
            [MBProgressHUD showSuccess:@"注册成功" ToView:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            
            [MBProgressHUD showError:request.responseJSONObject[@"errmsg"] ToView:nil];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
//        [MBProgressHUD showError:@"网络错误" ToView:nil];
    }];
    

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






#pragma mark 网络请求

-(void)getVerificationCode
{
    GetCapchaService *request = [[GetCapchaService alloc] initRegistWithPhoneNum:self.phoneNo];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"验证码 %@",request.responseString);
        if ([request.responseJSONObject[@"errcode"] isEqual:@0]) {
            
        }else{
            
            [MBProgressHUD showError:request.responseJSONObject[@"errmsg"] ToView:nil];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [MBProgressHUD showError:@"网络错误" ToView:nil];
        
    }];
    
}


@end
