//
//  IncomeManageViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/21.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "IncomeManageViewController.h"
#import "IncomeManageTableViewCell.h"
#import "UIView+NTES.h"
#import "IncomeStatementViewController.h"

@interface IncomeManageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) UIView *tipView;
@property (nonatomic,strong) UIButton *cover;

@end

@implementation IncomeManageViewController
{
    UIImageView *_backView;
    UILabel *_surplus; // 余额
    
}
-(void)setNavBar
{
    [self.navigationView setNavigationBackgroundAlpha:0];

    [self.navigationView setTitle:@"收入管理"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"收入说明" clickCallBack:^(UIView *view) {
        IncomeStatementViewController *income = [[IncomeStatementViewController alloc] init];
        [weakself.navigationController pushViewController:income animated:YES];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    
    _backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue_bg"]];
    [_backView sizeToFit];
    [self.view addSubview:_backView];
    _backView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(_backView.height);
    
    
    [self setupSubViews];
    
    [self setupTableView];
}

-(void)setupSubViews
{
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.borderColor = [UIColor whiteColor].CGColor;
    icon.layer.borderWidth = 2;
    icon.layer.cornerRadius = 40;
    icon.layer.masksToBounds = YES;
    icon.image = [UIImage imageNamed:@"header_icon_line"];
    
    [self.view addSubview:icon];
    
    icon.sd_layout.centerXEqualToView(_backView).centerYIs(_backView.bottom).widthIs(80).heightIs(80);
    
    
    // 账户余额
    
    UILabel *surplusLabel = [[UILabel alloc] init];
    surplusLabel.font = PingFangFONT(13);
    surplusLabel.textColor = darkzhongColor;
    surplusLabel.text = @"账户余额(元)";
    
    [self.view addSubview:surplusLabel];
    
    surplusLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(icon, 37).heightIs(surplusLabel.font.lineHeight);
    [surplusLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    
    UILabel *surplus = [[UILabel alloc] init];
    _surplus = surplus;
    surplus.font = [UIFont fontWithName:@"Helvetica-Bold" size:45.0f];
    surplus.textColor = RGB(72, 147, 245);
    surplus.text = [NSString stringWithFormat:@"%.2f",12313.12f];
    
    [self.view addSubview:surplus];
    
    surplus.sd_layout.centerXEqualToView(self.view).topSpaceToView(surplusLabel, 29).heightIs(surplus.font.lineHeight);
    [surplus setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    
    // 提交
    UIButton *submit = [[UIButton alloc] init];
    [submit setBackgroundImage:[UIImage imageNamed:@"circular_button"] forState:UIControlStateNormal];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(didClickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [submit sizeToFit];
    
    [self.view addSubview:submit];
    
    submit.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, 43).widthIs(submit.width).heightIs(submit.height);
    
    
}

#define Identifier @"IncomeManageTableViewCell"
-(void)setupTableView
{
    
    UITableView *tableView = [[UITableView alloc] init];
    self.tableview = tableView;
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[IncomeManageTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableView];
    
    tableView.sd_layout.leftEqualToView(self.view).topSpaceToView(_surplus, 36).rightEqualToView(self.view).heightIs(46*3);
    
 
    
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    IncomeManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.indexPath = indexPath;
    //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}




// 点击提交
-(void)didClickSubmit
{
    self.cover.hidden = NO;
    [self.view presentView:self.tipView animated:YES complete:^{
        
    }];
    
}


// 点击提示
-(void)didClickTip
{
    self.cover.hidden = YES;
    [self.view dismissPresentedView:YES complete:^{
        
    }];

}





#pragma mark 懒加载

-(UIView *)tipView
{
    
    UIView *tipView = [[UIView alloc] init];
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.layer.cornerRadius = 14;
    tipView.layer.masksToBounds = YES;
    
    
    UIImageView *tipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watchout_icon"]];
    [tipImage sizeToFit];
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = PingFangFONT(16);
    tipLabel.textColor = darkShenColor;
    tipLabel.text = @"还未开启提现功能";
    
    
    UIButton *tipBtn = [[UIButton alloc] init];
    tipBtn.layer.cornerRadius = 19;
    tipBtn.layer.masksToBounds = YES;
    [tipBtn setBackgroundImage:[UIImage imageNamed:@"circular_button"] forState:UIControlStateNormal];
    [tipBtn setTitle:@"确定" forState:UIControlStateNormal];
    [tipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipBtn.titleLabel.font = PingFangFONT(18);
    [tipBtn addTarget:self action:@selector(didClickTip) forControlEvents:UIControlEventTouchUpInside];
    
    [tipView addSubview:tipImage];
    [tipView addSubview:tipLabel];
    [tipView addSubview:tipBtn];
    
    tipView.sd_layout.widthIs(214).heightIs(214);
    
    tipImage.sd_layout.centerXEqualToView(tipView).topSpaceToView(tipView, 37).widthIs(tipImage.width).heightIs(tipImage.height);
    
    
    tipLabel.sd_layout.centerXEqualToView(tipView).topSpaceToView(tipImage, 17).heightIs(tipLabel.font.lineHeight);
    [tipLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    tipBtn.sd_layout.centerXEqualToView(tipView).topSpaceToView(tipLabel, 29).widthIs(109).heightIs(38);
    
    
    return tipView;
}



-(UIButton *)cover
{
    
    if (!_cover) {
        
        _cover = [[UIButton alloc] init];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0.7;
//        [_cover addTarget:self action:@selector(didClickCover) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:_cover];
        _cover.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _cover.hidden = YES;
        
    }
    return _cover;
    
}


@end
