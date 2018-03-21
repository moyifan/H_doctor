//
//  AddCommonDrugsViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AddCommonDrugsViewController.h"
#import "AddCommonDrugsTableViewCell.h"
#import "DrugsDetailTableViewCell.h"
#import "DrugDetailViewController.h"

@interface AddCommonDrugsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITextField *search;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UITableView *detailTableview;

@end

@implementation AddCommonDrugsViewController


-(void)setNavBar
{
    [self.navigationView setTitle:@"添加常用药"];
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    
    [self setupSearch];

    [self setupTableView];
    
    
//
//    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//
//    if ([self.tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
//
//    {
//        [self.tableview.delegate tableView:self.tableview didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//    }
}


-(void)setupSearch
{
    [self.view addSubview:self.search];
    
    self.search.sd_layout.leftSpaceToView(self.view, 15).rightSpaceToView(self.view, 15).topSpaceToView(self.view, 8+64).heightIs(28);
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    [self.view addSubview:line];
    
    line.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.search, 9).heightIs(1);
    
}



#define Identifier @"AddCommonDrugsTableViewCell"
#define Identifier1 @"DrugsDetailTableViewCell"

-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    self.tableview = tableView;
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.backgroundColor = AllBG;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[AddCommonDrugsTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableView];
    
    tableView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.search, 10).bottomEqualToView(self.view).widthIs(118);
    
    
    
    UITableView *table1 = [[UITableView alloc] init];
    self.detailTableview = tableView;
    table1.dataSource = self;
    table1.delegate  = self;
    table1.backgroundColor = AllBG;
    table1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table1 registerClass:[DrugsDetailTableViewCell class] forCellReuseIdentifier:Identifier1];
    
    
    [self.view addSubview:table1];
    
    table1.sd_layout.leftSpaceToView(tableView, 0).topSpaceToView(self.search, 10).bottomEqualToView(self.view).rightEqualToView(self.view);
    
    
    
  
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableview) {
        return 5;
    }else{
        return 5;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableview) {
        
        AddCommonDrugsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = RGB(239, 239, 241);
 
        
        return cell;
        
    }else{
        
        DrugsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
        
        //// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableview) {
        AddCommonDrugsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.content.highlighted = YES;
        
        
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        DrugsDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.content.highlighted = YES;
        cell.detail.highlighted = YES;
        
        
        DrugDetailViewController *detail = [[DrugDetailViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}




#pragma mark 网络请求

//-(void)




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
        _search.placeholder = @"请输入您要搜索的药品名称";
        _search.textColor = darkShenColor;
        _search.font = PingFangFONT(14);
        _search.delegate = self;
        _search.returnKeyType = UIReturnKeySearch;
        
    }
    
    return _search;
}







@end
