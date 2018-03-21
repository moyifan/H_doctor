//
//  ChatVideoListViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ChatVideoListViewController.h"
#import "RecordLineViewController.h"
#import "ChatVideoListTableViewCell.h"

@interface ChatVideoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation ChatVideoListViewController
{
    QMUILabel *_state;
    UISwitch *_swi;
}
-(void)setNavBar
{
    
    [self.navigationView setTitle:@"图文问诊"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"接诊记录" clickCallBack:^(UIView *view) {
        RecordLineViewController *line = [[RecordLineViewController alloc] init];
        [weakself.navigationController pushViewController:line animated:YES];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = backBG;
    
    [self setNavBar];
    
    [self setSubViews];
    
    [self setupTableView];

}



-(void)setSubViews
{
    QMUILabel *state = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    _state = state;
    state.text = @"我的接诊状态";
    state.backgroundColor = [UIColor whiteColor];
    state.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self.view addSubview:state];
    
    
    state.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, 64).rightEqualToView(self.view).heightIs(44);
    
    
    //
    UISwitch *swi = [[UISwitch alloc] init];
    _swi = swi;
    swi.onTintColor = RGB(75, 139, 248);
    [swi addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:swi];
    
    swi.sd_layout.centerYEqualToView(state).rightSpaceToView(self.view, 16);
    
    
}


//选择
-(void)switchAction:(id)sender
{
   
    
}



#define Identifier @"ChatVideoListTableViewCell"

-(void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[ChatVideoListTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
    
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(_state, 0).rightEqualToView(self.view).bottomEqualToView(self.view);
    
    
}


#pragma mark tableviewData

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    QMUILabel *head = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkzhongColor];
    head.text = @"当前2人在排队...";
    head.contentEdgeInsets = UIEdgeInsetsMake(18, 17, 0, 0);
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatVideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
    return 65;
    
}

@end
