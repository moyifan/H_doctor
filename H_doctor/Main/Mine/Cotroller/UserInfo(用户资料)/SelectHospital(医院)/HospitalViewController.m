//
//  HospitalViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "HospitalViewController.h"
#import "HospitalTableViewCell.h"

@interface HospitalViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation HospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
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
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



@end
