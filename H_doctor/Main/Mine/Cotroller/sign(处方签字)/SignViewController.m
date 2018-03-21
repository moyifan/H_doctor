//
//  SignViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/12.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "SignViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "BaibanView.h"
#import "UploadSignImgService.h"

@import Photos; // 相册权限

@interface SignViewController ()
@property (nonatomic, strong) BaibanView *painterView;

@end

@implementation SignViewController



-(void)setNavBar
{
    [self.navigationView setTitle:@"处方签名"];
   
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = RGB(247, 247, 247);
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    
    [self.view addSubview:backView];
    
    backView.sd_layout.leftSpaceToView(self.view, 15).rightSpaceToView(self.view, 15).topSpaceToView(self.view, 64+16).heightIs(AdaptedWidth(236));
    
    
    //创建画板
    BaibanView *painterView= [[BaibanView alloc]init];
    painterView.backgroundColor = [UIColor clearColor];
    painterView.lineColor = [UIColor blackColor];
    painterView.layer.cornerRadius = 10;
    painterView.layer.masksToBounds = YES;
    self.painterView = painterView;
    [backView addSubview:painterView];
    
    self.painterView.sd_layout.leftEqualToView(backView).topEqualToView(backView).rightEqualToView(backView).bottomEqualToView(backView);
    
    
    
    UIButton *re_sign = [[UIButton alloc] init];
    [re_sign setBackgroundImage:[UIImage imageNamed:@"sign_re"] forState:UIControlStateNormal];
    [re_sign setTitle:@"重新签名" forState:UIControlStateNormal];
    [re_sign setTitleColor:RGB(72, 147, 245) forState:UIControlStateNormal];
    re_sign.titleLabel.font = PingFangFONT(18);
    [re_sign addTarget:self action:@selector(didClickSign) forControlEvents:UIControlEventTouchUpInside];
    [re_sign sizeToFit];
    
    UIButton *save = [[UIButton alloc] init];
    [save setBackgroundImage:[UIImage imageNamed:@"sign_s"] forState:UIControlStateNormal];
    [save setTitle:@"提交保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    save.titleLabel.font = PingFangFONT(18);
    [save addTarget:self action:@selector(didClickSave) forControlEvents:UIControlEventTouchUpInside];
    [save sizeToFit];
    
                               
    [self.view addSubview:re_sign];
    [self.view addSubview:save];
    
    
    re_sign.sd_layout.centerXEqualToView(self.view).topSpaceToView(backView, 52).widthIs(re_sign.width).heightIs(re_sign.height);
    save.sd_layout.centerXEqualToView(self.view).topSpaceToView(re_sign, 21).widthIs(save.width).heightIs(save.height);
    
    
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                
            }
        }];
        
    }
    
}


// 重新签名
-(void)didClickSign
{
    [self.painterView clear];
    
}

// 提交保存
-(void)didClickSave
{
    [self uploadSign];
}





#pragma mark 网络

-(void)uploadSign
{
    
    UploadSignImgService *request = [[UploadSignImgService alloc] initWithDocid:DoctorUserDefault.ID  signimg:[self.painterView capImage]];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"上传签名 %@",request.responseString);
        if ([request.responseJSONObject[@"code"] isEqual:@1]) {
            [MBProgressHUD showSuccess:@"上传成功，请等待审核" ToView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"上传签名 %@",request.error);
    }];
    
}


@end
