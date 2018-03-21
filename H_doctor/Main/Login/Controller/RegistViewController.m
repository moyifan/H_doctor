//
//  RegistViewController.m
//  hospital
//
//  Created by zhiren on 2017/7/3.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "RegistViewController.h"
#import "GetVerificationViewController.h"
@interface RegistViewController ()
@property (nonatomic,strong) UITextField *phoneNum; //手机号

@property (nonatomic,strong) UITextField *passWord; // 密码

@property (nonatomic,strong) UIButton *nextBtn; // 下一步

@end

@implementation RegistViewController

-(void)setNavBar
{
    [self.navigationView setTitle:self.Retitle];
    
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


    // 手机号
    self.phoneNum = [[UITextField alloc] init];
    _phoneNum.font = PingFangFONT(15);
    _phoneNum.placeholder = @"请输入手机号";
    [self.view addSubview:_phoneNum];
  
    
    _phoneNum.sd_layout.topSpaceToView(self.view,15+64).centerXEqualToView(self.view).heightIs(40).widthIs(345);
    
    // 创建分割线
    [_phoneNum creatLineView];
    
    
    
    // 密码
    self.passWord = [[UITextField alloc] init];
    _passWord.font = PingFangFONT(15);
    _passWord.placeholder = @"请设置登录密码";
    _passWord.secureTextEntry = YES;
    
    [self.view addSubview:_passWord];
    
    _passWord.sd_layout.topSpaceToView(_phoneNum,15).centerXEqualToView(_phoneNum).heightIs(40).widthIs(345);
    
    // 创建分割线
    [_passWord creatLineView];
  
    
    // 下一步
    _nextBtn = [[UIButton alloc] init];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"anjian_icon"] forState:UIControlStateNormal];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = PingFangFONT(17);
    [_nextBtn addTarget:self action:@selector(didClickNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nextBtn];
    
    _nextBtn.sd_layout.centerXEqualToView(self.view).topSpaceToView(_passWord, 50).widthIs(345).heightIs(50);
    
    
    
    

}



-(void)didClickNext
{
    
    if (self.phoneNum.text.length != 0 && self.passWord.text.length != 0 ){
        
        
        
        if ([self isMobileNumber:self.phoneNum.text]){
            
            
            
            if ([self isPassWord:self.passWord.text]){
                
            
                GetVerificationViewController *ver = [[GetVerificationViewController alloc] init];
                ver.phoneNo = self.phoneNum.text;
                ver.password = self.passWord.text;
                ver.Gtype = self.Retitle;
                [self.navigationController pushViewController:ver animated:YES];
                
                
            }else{   //判断密码
                
                
                [MBProgressHUD showError:@"密码格式不正确" ToView:nil];
            }
            
            
            
        }else{//判断是否为手机号
            
            
            [MBProgressHUD showError:@"请输入正确的手机号" ToView:nil];
            
        }
        
        
    }else{//手机号、验证码、密码是否为空
        
        [MBProgressHUD showError:@"请输入完整信息" ToView:nil];
        
    }
    
    
  
}




#pragma mark 账号密码判断
/**
 *  正则解析 手机号
 */
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189，181，177
     */
    NSString * MOBILE = @"^1[3|4|5||6|7|8|9|][0-9]\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[156]|7[0-9])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}



//密码

- (BOOL)isPassWord:(NSString *)passWord
{
    
    
    NSString *pattern = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    //passWord作为接受对象    evaluateWitnObject返回一个BOOL值
    BOOL isMatch = [pred evaluateWithObject:passWord];
    
    return isMatch;
    
}


@end
