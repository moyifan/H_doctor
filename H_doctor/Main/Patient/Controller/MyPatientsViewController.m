//
//  MyPatientsViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/10.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "MyPatientsViewController.h"
#import "PatientsTableViewCell.h"
#import "PatientDataViewController.h"

#import "GetMySickerService.h"
#import "GetPatientModel.h"
#import "GetMySickerByKeywordService.h"

@interface MyPatientsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) GetPatientModel *model;

@end

@implementation MyPatientsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    [self getMyPatient];
}


#define Identifier @"myPatientsCell"

-(void)setupSubViews
{
    UITableView *tableView = [[UITableView alloc] init];
    self.tableview = tableView;
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.backgroundColor = AllBG;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[PatientsTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableView];
    
    tableView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view).rightEqualToView(self.view);
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ds.count;;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    cell.model = self.model.ds[indexPath.row];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientDataViewController *data = [[PatientDataViewController alloc] init];
    data.patientId = [NSString stringWithFormat:@"%ld",self.model.ds[indexPath.row].dst];
    [self.navigationController pushViewController:data animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


#pragma mark 网络

-(void)getMyPatient
{
    
    GetMySickerService *request = [[GetMySickerService alloc] initWithDocid:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        NSLog(@"我的患者 %@",request.responseString);
        
        self.model = [GetPatientModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"我的患者 %@",request.error);
    }];
    
}



-(void)searchByKeyWord:(NSString *)keyword
{
    
    GetMySickerByKeywordService *request = [[GetMySickerByKeywordService alloc] initWithDocid:DoctorUserDefault.ID keyword:keyword];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"搜索我的患者 %@",request.responseString);
        
        self.model = [GetPatientModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"搜索我的患者 %@",request.error);
    }];
    
}


@end
