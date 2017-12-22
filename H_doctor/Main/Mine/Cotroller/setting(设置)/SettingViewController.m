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

@interface SettingViewController ()
@property (nonatomic, strong) WRCellView *changePhone;

@end

@implementation SettingViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"设置"];
    
    MPWeakSelf(self)
    [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    

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
