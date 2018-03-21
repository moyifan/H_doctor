//
//  MyPharmacyViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/4.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "MyPharmacyViewController.h"
#import "MyPharmacyTableViewCell.h"
//#import "AddCommonDrugsViewController.h"
#import "PrescriptionTemplateViewController.h"
#import "DrugDetailsViewController.h"
#import "DrugDetailViewController.h"

#import "UIScrollView+EmptyDataSet.h"

#import "DrugsModel.h"
#import "GetMyDrugStoreService.h"
#import "SearchMyDrugService.h"
#import "DeletMyDrugService.h"

@interface MyPharmacyViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UITextField *search;
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) DrugsModel *model;

@end

@implementation MyPharmacyViewController


-(void)setNavBar
{
    [self.navigationView setTitle:@"我的药房"];
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getMyDrugStore];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    
    [self setupSearch];

    [self setupTableView];
    
    [self setupButton];
    
    [self getMyDrugStore];
    
    

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



#define Identifier @"MyPharmacyTableViewCell"

-(void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[MyPharmacyTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
    
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.search, 10).rightEqualToView(self.view).bottomSpaceToView(self.view, 50);
    
    tableview.emptyDataSetSource = self;
    tableview.emptyDataSetDelegate = self;

    
}




-(void)setupButton
{
    
    UIView *btnBackView = [[UIView alloc] init];
    btnBackView.backgroundColor = lineBG;

    
    UIButton *add = [[UIButton alloc] init];
    [add setBackgroundColor:[UIColor whiteColor]];
    [add setImage:[UIImage imageNamed:@"add_drug_icon"] forState:UIControlStateNormal];
    [add setTitle:@"添加常用药" forState:UIControlStateNormal];
    [add setTitleColor:RGB(72, 147, 245) forState:UIControlStateNormal];
    add.titleLabel.font = PingFangFONT(16);
    [add addTarget:self action:@selector(didClickAdd) forControlEvents:UIControlEventTouchUpInside];
    [add lc_imageTitleHorizontalAlignmentWithSpace:10];
    
    
    UIButton *setting = [[UIButton alloc] init];
    [setting setBackgroundColor:[UIColor whiteColor]];
    [setting setImage:[UIImage imageNamed:@"setup_icon"] forState:UIControlStateNormal];
    [setting setTitle:@"设置处方模板" forState:UIControlStateNormal];
    [setting setTitleColor:RGB(72, 147, 245) forState:UIControlStateNormal];
    setting.titleLabel.font = PingFangFONT(16);
    [setting addTarget:self action:@selector(didClickSetting) forControlEvents:UIControlEventTouchUpInside];
    [setting lc_imageTitleHorizontalAlignmentWithSpace:10];

    
    [self.view addSubview:btnBackView];
    [btnBackView addSubview:add];
    [btnBackView addSubview:setting];
    
    btnBackView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
    
    add.sd_layout.leftEqualToView(btnBackView).bottomEqualToView(btnBackView).heightIs(49).widthIs(self.view.width/2-0.5);
    setting.sd_layout.rightEqualToView(btnBackView).bottomEqualToView(btnBackView).heightIs(49).widthRatioToView(add, 1);
    
    
}


#pragma mark touch
-(void)didClickAdd
{
    DrugDetailViewController *add = [[DrugDetailViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
    
}




-(void)didClickSetting
{
    PrescriptionTemplateViewController *pre = [[PrescriptionTemplateViewController alloc] init];
    pre.titleName = @"新建处方模板";
    pre.state = NewPre;
    [self.navigationController pushViewController:pre animated:YES];
    
}


#pragma mark NoData data source
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"pharmacy_icon_pic"];
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"当前未添加常用药";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:PingFangFONT(16),
                                 NSForegroundColorAttributeName:darkQianColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"点击左下角添加后，开处方更加方便哦！";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:AdaptedFontSize(14),
                                 NSForegroundColorAttributeName:darkQianColor,
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}





#pragma mark tableviewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ds.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyPharmacyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.check.hidden = YES;
    
    cell.model = self.model.ds[indexPath.row];
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
    return cell;
        
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DrugDetailsViewController *detail = [[DrugDetailsViewController alloc] init];
    detail.model = self.model.ds[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
    
    return [self.tableview cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView];
  
}




-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        
    
        [self deleteWithDrugID:[NSString stringWithFormat:@"%ld",self.model.ds[indexPath.row].ID]];
        
    }];//此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
    //    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    //
    //    }];
    //    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[deleteRoWAction];//最后返回这俩个RowAction 的数组
}





#pragma mark 网络

-(void)getMyDrugStore
{
    GetMyDrugStoreService *request = [[GetMyDrugStoreService alloc] initWithDocid:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"我的药房 %@",request.responseString);
        
        self.model = [DrugsModel yy_modelWithJSON:request.responseJSONObject];
    
        
        [self.tableview reloadData];
        [self.tableview reloadEmptyDataSet];

        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@" %@",request.error);
    }];
    
}


-(void)deleteWithDrugID:(NSString *)ID
{
    DeletMyDrugService *request = [[DeletMyDrugService alloc] initWithDocid:DoctorUserDefault.ID ID:ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"删除药方药品 %@",request.responseString);
        
        [self getMyDrugStore];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"删除失败" ToView:nil];
        NSLog(@"删除药方药品 %@",request.error);
    }];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    SearchMyDrugService *request = [[SearchMyDrugService alloc] initWithDocid:DoctorUserDefault.ID keyword:textField.text];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"搜索我的药房 %@",request.responseString);
        
        self.model = [DrugsModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        // 有数据时显示reloaddata，无数据时刷新emptydata
        [self.tableview reloadEmptyDataSet];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"搜索我的药房 %@",request.error);
    }];
    
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
        _search.placeholder = @"请输入您要搜索的药品名称";
        _search.textColor = darkShenColor;
        _search.font = PingFangFONT(14);
        _search.delegate = self;
        _search.returnKeyType = UIReturnKeySearch;
        
    }
    
    return _search;
}


@end
