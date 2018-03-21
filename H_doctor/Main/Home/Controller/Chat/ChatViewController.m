//
//  ChatViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/10.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ChatViewController.h"

#import "UUMessageCell.h"
#import "UUMessage.h"
#import "UUMessageFrame.h"
#import "MMChatInputView.h"

#import "ChatSocketCline.h"

@interface ChatViewController ()<UITableViewDataSource, UITableViewDelegate, UUMessageCellDelegate,MMChatInputViewDelegate>

@property (strong, nonatomic) SocketIOClient *socket;

@property (strong, nonatomic) UITableView *chatTableView;
@property (nonatomic, strong) NSMutableArray<UUMessageFrame *> *dataSource;

@property (strong, nonatomic) MMChatInputView *inputFuncView;

@end

@implementation ChatViewController
{
    CGFloat _keyboardHeight;
}

-(void)setNavBar
{
    
    [self.navigationView setTitle:self.navTitle];
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"开处方" clickCallBack:^(UIView *view) {
       
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //add notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];

}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backBG;
    [self setNavBar];
    
    
    self.socket = [ChatSocketCline shareSocketCline];
    
    [self initBasicViews];
    
    [self sendMessage];
    

//    [self addRefreshViews];
    
}


#pragma mark - prive methods

- (void)initBasicViews
{
    _chatTableView = [[UITableView alloc] init];
    _chatTableView.backgroundColor = backBG;
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;
    [self.view addSubview:_chatTableView];
    

    [_chatTableView registerClass:[UUMessageCell class] forCellReuseIdentifier:NSStringFromClass([UUMessageCell class])];

    _chatTableView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, 64).rightEqualToView(self.view).bottomSpaceToView(self.view, 54);
    
    
    
    _inputFuncView = [[MMChatInputView alloc] init];
    _inputFuncView.delegate = self;
  
    [self.view addSubview:_inputFuncView];
    
    _inputFuncView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view, 0).heightIs(54);
  
}


#pragma mark - InputFunctionViewDelegate

//- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
//{
//    [self.socket emit:@"msg" with:@[@{@"content":message}]];
//
//
//    funcView.textViewInput.text = @"";
//    [funcView changeSendBtnWithPhoto:YES];
//
//}


//- (void)addRefreshViews
//{
//    __weak typeof(self) weakSelf = self;
//
//    //load more
//    int pageNum = 10;
//
//    self.chatTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//
//        [weakSelf.chatModel addRandomItemsToDataSource:pageNum];
//
//        if (weakSelf.chatModel.dataSource.count > pageNum) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.chatTableView reloadData];
//                [weakSelf.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            });
//        }
//        [weakSelf.chatTableView.mj_header endRefreshing];
//    }];
//}



-(void)sendMessage
{
    
    
    [self.socket on:@"msg" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"接收别人的消息 %@",data);
        [self addItem:data[0] form:UUMessageFromOther];
    }];
    
    [self.socket on:@"msg_s" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"接收自己的消息 %@",data);
        [self addItem:data[0] form:UUMessageFromMe];
    }];
    
    
}



#pragma mark - tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UUMessageCell class])];
    cell.delegate = self;
    cell.messageFrame = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



#pragma mark - UUMessageCellDelegate

- (void)chatCell:(UUMessageCell *)cell headImageDidClick:(NSString *)userId
{
   
}


#pragma mark - MMTextViewDelegate

-(void)MMInputFunctionView:(MMChatInputView *)funcView sendMessage:(NSString *)message
{
   
    [self.socket emit:@"msg" with:@[@{@"content":message}]];
    
}



// 键盘状态改变
-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    _keyboardHeight = keyboardEndFrame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    
//    self.chatTableView.height = self.view.height - _inputFuncView.height;
//    self.chatTableView.height -= notification.name == UIKeyboardWillShowNotification ? _keyboardHeight:0;
    CGFloat changeHeight = notification.name == UIKeyboardWillShowNotification ? _keyboardHeight:0;
    self.chatTableView.contentOffset = CGPointMake(0, changeHeight);
    
    self.inputFuncView.sd_resetLayout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view, changeHeight).heightIs(54);
    [self.inputFuncView updateLayout];
//    self.inputFuncView.top = self.chatTableView.bottom;
    
    [UIView commitAnimations];
    
    
}



#pragma mark 日后再封装
static NSString *previousTime = nil;
// 添加自己的item
- (void)addItem:(NSDictionary *)dic form:(MessageFrom )from
{
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    UUMessage *message = [[UUMessage alloc] init];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    
    
    [dataDic setObject:@(from) forKey:@"from"];
    [dataDic setObject:[[NSDate date] description] forKey:@"strTime"];
    [dataDic setObject:dic[@"content"] forKey:@"strContent"];
    [dataDic setObject:@(UUMessageTypeText) forKey:@"type"];
    
    if (from == UUMessageFromMe) {
        [dataDic setObject:[UserInfo shareUserInfo].model.doc.realname forKey:@"strName"];
        [dataDic setObject:[UserInfo shareUserInfo].model.doc.img forKey:@"strIcon"];
    }else{
        NSString *URLStr = @"http://img0.bdstatic.com/img/image/shouye/xinshouye/mingxing16.jpg";
        [dataDic setObject:@"Hi:sister" forKey:@"strName"];
        [dataDic setObject:URLStr forKey:@"strIcon"];
    }
    
    
    [message setWithDict:dataDic];
    [message minuteOffSetStart:previousTime end:dataDic[@"strTime"]];
    messageFrame.showTime = message.showDateLabel;
    [messageFrame setMessage:message];
    
    if (message.showDateLabel) {
        previousTime = dataDic[@"strTime"];
    }
    [self.dataSource addObject:messageFrame];
    

    [self.chatTableView reloadData];
}


#pragma mark 懒加载

-(NSMutableArray<UUMessageFrame *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}




@end
