//
//  HospitalViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "HospitalViewController.h"
#import "HospitalTableViewCell.h"

#import "GetAllTagService.h"
#import "AllTagModel.h"

@interface HospitalViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) AllTagModel *tagModel;

@end

@implementation HospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    if (_hospitalState == title) {
        
        [self getAllTag];
        
    }
    
    
}


#define Identifier @"HospitalTableViewCell"

-(void)setupSubViews
{
    UITableView *tableView = [[UITableView alloc] init];
    self.tableview = tableView;
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.backgroundColor = RGB(242, 246, 250);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[HospitalTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableView];
    
    tableView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view).rightEqualToView(self.view);
    
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_hospitalState == title) {
        return self.tagModel.list.count;
    }else{
        return self.hosModel.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (_hospitalState == title) {
        cell.content.text = self.tagModel.list[indexPath.row].tagname;
    }else{
        cell.content.text = self.hosModel[indexPath.row].hosptlname;

    }

    //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_hospitalState == title) {
        if (self.ReturnValueBlock) {
            self.ReturnValueBlock(self.tagModel.list[indexPath.row].tagname);
        }
    }else{
        if (self.ReturnHosValueBlock) {
            self.ReturnHosValueBlock(self.hosModel[indexPath.row].hosptlname, [NSString stringWithFormat:@"%ld",self.hosModel[indexPath.row].ID]);
        }
    }

    
    [self.navigationController popViewControllerAnimated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}




-(void)setHosModel:(NSArray<Hosptllist *> *)hosModel
{
    _hosModel = hosModel;
    
    [self.tableview reloadData];
}




#pragma mark 网络

-(void)getAllTag
{
    GetAllTagService *request = [[GetAllTagService alloc] init];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"全部职称 %@",request.responseString);
        
        self.tagModel = [AllTagModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@" %@",request.error);
    }];
    
}




@end
