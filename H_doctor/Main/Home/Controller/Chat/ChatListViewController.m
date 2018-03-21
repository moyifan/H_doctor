//
//  ChatListViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/10.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatVideoListTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"

#import "RecordLineViewController.h"
#import "ChatViewController.h"

#import "ChatListModel.h"
#import "GetChatListService.h"
#import "ReceiveService.h"

#import "ChatSocketCline.h"

@interface ChatListViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) SocketIOClient *socket;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) ChatListModel *model;

@end

@implementation ChatListViewController
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
    self.view.backgroundColor = [UIColor whiteColor];

    [self setNavBar];
    
    [self socketChat];
    
    [self setSubViews];

    [self setupTableView];
    
    // 有数据时显示reloaddata，无数据时刷新emptydata
    [self.tableview reloadEmptyDataSet];
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
-(void)switchAction:(UISwitch *)sender
{
    if (sender.on) {
        
        [self startReceive];
    }else{
        
    }
    
}



#define Identifier @"ChatListTableViewCell"

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
    
    tableview.emptyDataSetSource = self;
    tableview.emptyDataSetDelegate = self;
    
    
}



#pragma mark NoData data source
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"jilu_icon"];
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"当前没有问诊人员!";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:PingFangFONT(16),
                                 NSForegroundColorAttributeName:darkQianColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}



- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}



#pragma mark tableviewData

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    QMUILabel *head = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkzhongColor];
    head.text = [NSString stringWithFormat:@"当前%ld人在排队...",self.model.ds.count];
    head.contentEdgeInsets = UIEdgeInsetsMake(18, 17, 0, 0);
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 由于web视频图文不分开，所以调整展示形式
    ChatVideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];

    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    cell.model = self.model.ds[indexPath.row];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self receicewith:self.model.ds[indexPath.row]];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
//    return 75;
    return 65;
}




//
-(void)socketChat
{
    
    // socket连接
    self.socket = [ChatSocketCline shareSocketCline];
    
    MPWeakSelf(self)
    [self.socket on:@"queuelist" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"排队列表 ");

        [weakself getList];
        
    }];
    
   
    
    
    //    [socket on:@"currentAmount" callback:^(NSArray* data, SocketAckEmitter* ack) {
    //        double cur = [[data objectAtIndex:0] floatValue];
    //
    //        [[socket emitWithAck:@"canUpdate" with:@[@(cur)]] timingOutAfter:0 callback:^(NSArray* data) {
    //            [socket emit:@"update" with:@[@{@"amount": @(cur + 2.50)}]];
    //        }];
    //
    //        [ack with:@[@"Got your currentAmount, ", @"dude"]];
    //    }];
    
}

-(void)startReceive
{
    [self.socket emit:@"docstart" with:@[@{@"docid":DoctorUserDefault.ID}]];
    
    [self.socket on:@"docstart" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"开始接诊成功");
    }];
    
}


#pragma mark 网络

-(void)getList
{
    
    GetChatListService *request = [[GetChatListService alloc] initWithDocid:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"排队列表 %@",request.responseString);
        
        self.model = [ChatListModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];

        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"排队列表 %@",request.error);
    }];
    
}

-(void)receicewith:(ChatModel *)model
{
    MPWeakSelf(self)
    ReceiveService *request = [[ReceiveService alloc] initWithDocid:DoctorUserDefault.ID dstid:[NSString stringWithFormat:@"%ld",model.dstid] caseid:[NSString stringWithFormat:@"%ld",model.caseid]];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"接诊 %@",request.responseString);
        
        [self.socket emit:@"ready" with:@[@{@"userid":[NSString stringWithFormat:@"%ld",model.dstid],@"inquiryid":request.responseJSONObject[@"inquiryid"]}]];

        
        
        // 接诊
        [self.socket on:@"ready" callback:^(NSArray * data, SocketAckEmitter * ack) {
            NSLog(@"接诊");
            ChatViewController *chat = [[ChatViewController alloc] init];
            chat.navTitle = model.realname1;
            chat.ID = [NSString stringWithFormat:@"%ld",model.dstid];
            chat.realName = model.realname1;
            chat.Img = model.img;
            [weakself.navigationController pushViewController:chat animated:YES];
        }];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"接诊 %@",request.error);
    }];
    
    
}



@end
