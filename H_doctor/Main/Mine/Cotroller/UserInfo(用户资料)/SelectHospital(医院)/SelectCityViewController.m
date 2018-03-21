//
//  SelectCityViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "SelectCityViewController.h"
#import "ControlTableViewCell.h"
#import "DetailTableViewCell.h"
#import "GetAllSection.h"
#import "AllSectionModel.h"

#import "GetProvCityAndHospitalService.h"

@interface SelectCityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UITableView *detailTableview;
@property (nonatomic,strong) AllSectionModel *sectionModel;
@property (nonatomic,strong) AllCityModel *allCityModel;

@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    if (_cityState == office) {
        
        [self getAllOffice];
    }else{
        
        [self getAllHospital];
    }
    
    
}


#define Identifier @"ControlTableViewCell"
#define Identifier1 @"DetailTableViewCell"

-(void)setupSubViews
{
    UITableView *tableView = [[UITableView alloc] init];
    self.tableview = tableView;
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[ControlTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableView];
    
    tableView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view).widthIs(112);
    
    
    
    UITableView *table1 = [[UITableView alloc] init];
    self.detailTableview = table1;
    table1.dataSource = self;
    table1.delegate  = self;
    table1.backgroundColor = RGB(235, 235, 238);
    table1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table1 registerClass:[DetailTableViewCell class] forCellReuseIdentifier:Identifier1];
    
    
    [self.view addSubview:table1];
    
    table1.sd_layout.leftSpaceToView(tableView, 0).topEqualToView(self.view).bottomEqualToView(self.view).rightEqualToView(self.view);
 
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_cityState == office) {
        
        if (tableView == self.tableview) {
            return self.sectionModel.list.count;
        }else{
            NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
            NSArray *array = self.sectionModel.list[indexPath.row].nodes;
            return array.count;
        }
    }else{
        
        if (tableView == self.tableview) {
            return self.allCityModel.ds.count;
        }else{
            NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
            NSArray *array = self.allCityModel.ds[indexPath.row].citylist;
            return array.count;
        }
    }
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cityState == office) {
        
        
        if (tableView == self.tableview) {
            
            ControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            
            //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.content.text = self.sectionModel.list[indexPath.row].sectionname;
            
            return cell;
            
        }else{
            
            DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
            
            //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            NSIndexPath *selectRow = [self.tableview indexPathForSelectedRow];
            
            cell.content.text = self.sectionModel.list[selectRow.row].nodes[indexPath.row].sectionname;
            // 记得改 该字段是显示里面有多少个医生
            cell.detail.text = [NSString stringWithFormat:@"%ld",self.sectionModel.list[selectRow.row].nodes[indexPath.row].levels];
            
            
            return cell;
        }
        
        
    }else{
        
        if (tableView == self.tableview) {
            
            ControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            
            //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            cell.content.text = self.allCityModel.ds[indexPath.row].prov;
            
            return cell;
            
        }else{
            
            DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
            
            //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            NSIndexPath *selectRow = [self.tableview indexPathForSelectedRow];
            
            cell.content.text = self.allCityModel.ds[selectRow.row].citylist[indexPath.row].name;
            // 记得改 该字段是显示里面有多少个医生
            cell.detail.text = [NSString stringWithFormat:@"%ld",self.allCityModel.ds[selectRow.row].citylist[indexPath.row].count];
            
            
            return cell;
        }
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableview) {
        
        [self.detailTableview reloadData];
        
    }else{
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSIndexPath *selectRow = [self.tableview indexPathForSelectedRow];
        
        if (_cityState == office) {
            
            if (self.ReturnValueBlock) {
                self.ReturnValueBlock(self.sectionModel.list[selectRow.row].nodes[indexPath.row].sectionname,self.sectionModel.list[selectRow.row].nodes[indexPath.row].ID);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            if (self.ReturnHosValueBlock) {
                self.ReturnHosValueBlock(self.allCityModel.ds[selectRow.row].citylist[indexPath.row].hosptllist);
            }
            
        }
        
        
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}




#pragma mark 网络请求

// 全部科室
-(void)getAllOffice
{
   
    GetAllSection *request = [[GetAllSection alloc] init];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"全部科室 %@",request.responseString);
        
        self.sectionModel = [AllSectionModel yy_modelWithJSON:request.responseJSONObject];

        [self.tableview reloadData];
        
        
        if (self.sectionModel.list.count == 0) {
            return ;
        }
      
        NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableview selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [self.detailTableview reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@" %@",request.error);
    }];
    
}



-(void)getAllHospital
{
    GetProvCityAndHospitalService *request = [[GetProvCityAndHospitalService alloc] init];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"全部医院 %@",request.responseString);
        
        self.allCityModel = [AllCityModel yy_modelWithJSON:request.responseJSONObject];

        [self.tableview reloadData];
        
        if (self.allCityModel.ds.count == 0) {
            return ;
        }
        
        NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableview selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [self.detailTableview reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@" %@",request.error);
    }];
    
}







@end
