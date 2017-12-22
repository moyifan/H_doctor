//
//  MineViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/6.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "MineViewController.h"
#import "WRCellView.h"

#import "SignViewController.h"
#import "RealNameViewController.h"
#import "UserInfoViewController.h"
#import "CertificationViewController.h"
#import "IncomeManageViewController.h"
#import "SettingViewController.h"


@interface MineViewController ()

@property (nonatomic,strong) UIImageView *showView;
@property (nonatomic,strong) UIImageView *headView;
@property (nonatomic,strong) UILabel *nickName;


@property (nonatomic, strong) WRCellView *realNameView;
@property (nonatomic, strong) WRCellView *jobView;
@property (nonatomic, strong) WRCellView *moneyView;
@property (nonatomic, strong) WRCellView *signView;
@property (nonatomic, strong) WRCellView *settingView;

@end

@implementation MineViewController

-(void)setNavBar
{
    [self.navigationView setNavigationBackgroundAlpha:0];
    
    
    [self.navigationView addRightButtonWithImage:[UIImage imageNamed:@"news_icon"] hightImage:nil clickCallBack:^(UIView *view) {
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGB(242, 246, 250);
    
    [self setNavBar];
    
    
    // 展示View
    
    _showView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gerenzhongxinbg_icon"]];
    _showView.userInteractionEnabled = YES;
    
    [self.view addSubview:_showView];
    _showView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(240);
    
    
    
    // 添加约束
    [self setupSubviews];
    

    [self onClickEvent];
}


-(void)setupSubviews
{
 
    
    
    [self.showView addSubview:self.headView];
    [self.showView addSubview:self.nickName];
    
    self.headView.sd_layout.centerXEqualToView(self.showView).topSpaceToView(self.showView, 98).widthIs(72).heightIs(72);
    
    self.nickName.sd_layout.centerXEqualToView(self.headView).topSpaceToView(self.headView, 24).heightIs(self.nickName.font.lineHeight);
    [self.nickName setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    [self.view addSubview:self.realNameView];
    [self.view addSubview:self.jobView];
    [self.view addSubview:self.moneyView];
    [self.view addSubview:self.signView];
    [self.view addSubview:self.settingView];

    
    
    self.realNameView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.showView, 0).rightEqualToView(self.view).heightIs(AdaptedWidth(45));
    self.jobView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.realNameView, 0).rightEqualToView(self.view).heightIs(AdaptedWidth(45));
    self.moneyView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.jobView, 0).rightEqualToView(self.view).heightIs(AdaptedWidth(45));
    self.signView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.moneyView, 0).rightEqualToView(self.view).heightIs(AdaptedWidth(45));
    self.settingView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.signView, 0).rightEqualToView(self.view).heightIs(AdaptedWidth(45));
    
    
    
}



- (void)onClickEvent
{
    __weak typeof(self) weakSelf = self;
    self.realNameView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        pThis.realNameView.rightLabel.text = @"已实名";
        pThis.realNameView.rightLabel.textColor = darkQianColor;
        [pThis.realNameView layoutSubviews];
        
        RealNameViewController *real = [[RealNameViewController alloc] init];
        [pThis.navigationController pushViewController:real animated:YES];
    };
    self.jobView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        CertificationViewController *cer = [[CertificationViewController alloc] init];
        [pThis.navigationController pushViewController:cer animated:YES];
    };
    self.moneyView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        IncomeManageViewController *cer = [[IncomeManageViewController alloc] init];
        [pThis.navigationController pushViewController:cer animated:YES];
    };
    self.signView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        SignViewController *sign = [[SignViewController alloc] init];
        [pThis.navigationController pushViewController:sign animated:YES];
    };
    self.settingView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        SettingViewController *setting = [[SettingViewController alloc] init];
        [pThis.navigationController pushViewController:setting animated:YES];
    };

}


// 点击头像
-(void)didClickHead:(UITapGestureRecognizer *)sender{
    
    UserInfoViewController *userInfo = [[UserInfoViewController alloc] init];

    [self.navigationController pushViewController:userInfo animated:YES];
}



#pragma mark 懒加载

-(UIImageView *)headView
{
    if (!_headView) {
        
        _headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yishengtouxiang_icon"]];
        _headView.layer.cornerRadius = 36;
        _headView.layer.masksToBounds = YES;
        _headView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickHead:)];
        headTap.numberOfTapsRequired = 1;
        [_headView addGestureRecognizer:headTap];
        
    }
    
    return _headView;
    
}


-(UILabel *)nickName
{
    if (!_nickName) {
        
        _nickName = [[UILabel alloc] init];
        _nickName.textColor = RGB(254, 254, 254);
        _nickName.font = [UIFont fontWithName:(@"PingFangSC-Semibold") size:19];
        _nickName.text = @"Richard";
    }
    
    return _nickName;
}



-(WRCellView *)realNameView
{
    
    if (!_realNameView) {
        
        _realNameView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_LabelIndicator];
        _realNameView.leftIcon.image = [UIImage imageNamed:@"shimingrenzheng_icon"];
        _realNameView.leftLabel.text = @"实名认证";
        _realNameView.rightLabel.text = @"未实名";
        _realNameView.rightLabel.textColor = [UIColor redColor];
        [_realNameView setLineStyleWithLeftEqualLabelLeft];

    }
    
    return _realNameView;
    
}


-(WRCellView *)jobView
{
    
    if (!_jobView) {
        
        _jobView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_LabelIndicator];
        _jobView.leftIcon.image = [UIImage imageNamed:@"zhiyezigerenzheng_icon"];
        _jobView.leftLabel.text = @"职业资格认证";
        _jobView.rightLabel.text = @"未认证";
        _jobView.rightLabel.textColor = [UIColor redColor];
        [_jobView setLineStyleWithLeftEqualLabelLeft];

    }
    
    return _jobView;
    
}

-(WRCellView *)moneyView
{
    
    if (!_moneyView) {
        
        _moneyView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_LabelIndicator];
        _moneyView.leftIcon.image = [UIImage imageNamed:@"shimingrenzheng_icon"];
        _moneyView.leftLabel.text = @"收入管理";
        _moneyView.rightLabel.text = [NSString stringWithFormat:@"余额:%.2f元",0.00];
        _moneyView.rightLabel.textColor = darkQianColor;
        [_moneyView setLineStyleWithLeftEqualLabelLeft];

    }
    
    return _moneyView;
    
}

-(WRCellView *)signView
{
    
    if (!_signView) {
        
        _signView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_LabelIndicator];
        _signView.leftIcon.image = [UIImage imageNamed:@"chufangqianzi_icon"];
        _signView.leftLabel.text = @"处方签字";
        _signView.rightLabel.text = @"未添加";
        _signView.rightLabel.textColor = [UIColor redColor];
        [_signView setLineStyleWithLeftEqualLabelLeft];

        
    }
    
    return _signView;
    
}


-(WRCellView *)settingView
{
    
    if (!_settingView) {
        
        _settingView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_LabelIndicator];
        _settingView.leftIcon.image = [UIImage imageNamed:@"setup_icon"];
        _settingView.leftLabel.text = @"设置";
        _settingView.rightLabel.text = @"";
        [_settingView setLineStyleWithLeftZero];

    }
    
    return _settingView;
    
}






@end




