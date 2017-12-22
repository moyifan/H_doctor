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

@interface SelectCityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UITableView *detailTableview;

@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
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
    self.detailTableview = tableView;
    table1.dataSource = self;
    table1.delegate  = self;
    table1.backgroundColor = RGB(235, 235, 238);
    table1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table1 registerClass:[DetailTableViewCell class] forCellReuseIdentifier:Identifier1];
    
    
    [self.view addSubview:table1];
    
    table1.sd_layout.leftSpaceToView(tableView, 0).topEqualToView(self.view).bottomEqualToView(self.view).rightEqualToView(self.view);
 
    
    
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableview) {
        return 20;
    }else{
        return 10;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableview) {
        
        ControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        return cell;
    
    }else{
        
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
        
        //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableview) {
        

        
    }else{
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
      
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}





@end
