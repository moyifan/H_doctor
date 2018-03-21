//
//  RecordChatViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "RecordChatViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "ContactRecordTableViewCell.h"

#import "GetSignSickerAllInquiryService.h"
#import "RecordListModel.h"

@interface RecordChatViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) RecordListModel *model;

@end


@implementation RecordChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    [self getChatRecord];
    
}


#define Identifier @"RecordChatTableViewCell"

-(void)setupSubViews
{
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[ContactRecordTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
    
    
    tableview.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    
    tableview.emptyDataSetSource = self;
    tableview.emptyDataSetDelegate = self;
    

    
}


#pragma mark NoData data source
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"jilu_icon"];
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"当前没有接诊记录哦!";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:PingFangFONT(16),
                                 NSForegroundColorAttributeName:darkQianColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}



- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ds.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    
    cell.model = self.model.ds[indexPath.row];
    //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableview cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView];
}




#pragma mark 网络

-(void)getChatRecord
{
    GetSignSickerAllInquiryService *request = [[GetSignSickerAllInquiryService alloc] initWithDocid:self.userId type:@"0"];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//                NSLog(@"图文问诊记录 %@",request.responseString);
        
        self.model = [RecordListModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        // 有数据时显示reloaddata，无数据时刷新emptydata
        [self.tableview reloadEmptyDataSet];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"图文问诊记录 %@",request.error);
    }];
    
}





@end
