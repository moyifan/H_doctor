//
//  ContactAllRecordViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/3/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ContactAllRecordViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "ContactRecordTableViewCell.h"

#import "GetInquiryService.h"
#import "RecordListModel.h"
#import "GetInquiryByKeyWordService.h"

@interface ContactAllRecordViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UITextField *search;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) RecordListModel *model;


@end

@implementation ContactAllRecordViewController


-(void)setNavBar
{
    [self.navigationView setTitle:@"接诊记录"];
    
//    MPWeakSelf(self)
    //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
    //     [weakself.navigationController popViewControllerAnimated:YES];
    // }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self setupSearch];
    
    [self setupSubViews];
    
    [self getRecord];
}



-(void)setupSearch
{
    UIView *searchView = [[UIView alloc] init];
    self.searchView = searchView;
    searchView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:searchView];
    [searchView addSubview:self.search];
    
    
    searchView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).heightIs(44);
    
    self.search.sd_layout.leftSpaceToView(searchView, 15).rightSpaceToView(searchView, 15).centerYEqualToView(searchView).heightIs(28);
    
    
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
    
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.searchView, 0).rightEqualToView(self.view).bottomEqualToView(self.view);
    
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
-(void)getRecord
{
    GetInquiryService *request = [[GetInquiryService alloc] initWithDocid:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"问诊记录 %@",request.responseString);
        
        self.model = [RecordListModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        // 有数据时显示reloaddata，无数据时刷新emptydata
        [self.tableview reloadEmptyDataSet];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"图文问诊记录 %@",request.error);
    }];
    
}



-(void)searchByKeyWord:(NSString *)keyWord
{
    GetInquiryByKeyWordService *request = [[GetInquiryByKeyWordService alloc] initWithDocid:DoctorUserDefault.ID keyword:keyWord];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                NSLog(@"搜索接诊记录 %@",request.responseString);
        
        self.model = [RecordListModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        // 有数据时显示reloaddata，无数据时刷新emptydata
        [self.tableview reloadEmptyDataSet];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"搜索我的药房 %@",request.error);
    }];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [self searchByKeyWord:textField.text];
    
    return YES;
}




#pragma mark 懒加载

-(UITextField *)search
{
    if (!_search) {
        
        _search = [[UITextField alloc] init];
        [_search setBackground:[UIImage imageNamed:@"sousuokuang_icon"]];
        UIImageView *left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fangdajing_icon"]];
        [left sizeToFit];
        _search.leftView = left;
        _search.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _search.placeholder = @"请输入您要搜索的关键字";
        _search.textColor = darkShenColor;
        _search.font = PingFangFONT(14);
        _search.delegate = self;
        _search.returnKeyType = UIReturnKeySearch;
        
    }
    
    return _search;
}

@end
