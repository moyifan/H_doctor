//
//  AddDrugsSearchViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AddDrugsSearchViewController.h"
#import "MyPharmacyTableViewCell.h"
#import "AddDrugsDetailViewController.h"
#import "DrugDetailsViewController.h"

#import "GetDrugListService.h"
#import "DrugListModel.h"
#import "AddMyDrugService.h"
#import "DrugsModel.h"
#import "GetDrugListWithKeyWordService.h"
#import "UIScrollView+MJRefreshEX.h"
#import "NewPrescriptionModel.h"

@interface AddDrugsSearchViewController ()<QMUITextFieldDelegate,QMUITableViewDataSource,QMUITableViewDelegate,MJRefreshEXDelegate>

@property (nonatomic,strong) QMUITextField *search;
@property (nonatomic,strong) QMUITableView *tableview;


@property (nonatomic,strong) DrugsModel *model;

@property (nonatomic,assign) BOOL isSearch;

@end

@implementation AddDrugsSearchViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"添加药品"];
    
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



#define Identifier @"addDrugsSearchCell"

-(void)setupTableView
{
    QMUITableView *tableview = [[QMUITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[MyPharmacyTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
    
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.search, 10).rightEqualToView(self.view).bottomEqualToView(self.view);
    
    [tableview addHeaderWithHeaderClass:nil beginRefresh:YES delegate:self animation:YES];
    [tableview addFooterWithFooterClass:nil automaticallyRefresh:YES delegate:self];
    
    
}




#pragma mark tableviewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ds.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPharmacyTableViewCell *cell = [[MyPharmacyTableViewCell alloc] initForTableView:self.tableview withReuseIdentifier:Identifier];
    
    cell.model = self.model.ds[indexPath.row];

    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    
    [cell.check addTarget:self action:@selector(didClickCheck:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddDrugsDetailViewController *detail = [[AddDrugsDetailViewController alloc] init];
    detail.model = [PrescriptionDrugs yy_modelWithJSON:[self.model.ds[indexPath.row] yy_modelToJSONObject]];
    if (self.state == NewAdd) {
        detail.isEdit = NO;
        detail.saveState = NewSave;
        
    }else{
        detail.isEdit = YES;
        detail.editSaveState = EditNewSave;
        detail.templetId = self.templetId;
    }
    [self.navigationController pushViewController:detail animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
    
    return [self.tableview cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView];
    
}



-(void)didClickCheck:(UIButton *)sender
{
    NSIndexPath *selectRow = [self.tableview indexPathForSelectedRow];
    DrugDetailsViewController *detail = [[DrugDetailsViewController alloc] init];
    detail.model = self.model.ds[selectRow.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}




#pragma mark 刷新
- (void)onRefreshing:(id)control {
    
    if (self.isSearch) {
        [self getDrugListWithKeyWord:self.search.text Page:@"1" isHeader:YES];
    }else{
        [self getDrugListWithPage:@"1" isHeader:YES];
        
    }
    
}

- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    if (self.isSearch) {
        [self getDrugListWithKeyWord:self.search.text Page:[NSString stringWithFormat:@"%ld",pageNum.integerValue] isHeader:NO];
    }else{
        [self getDrugListWithPage:[NSString stringWithFormat:@"%ld",pageNum.integerValue] isHeader:NO];
        
    }
    
}



#pragma mark 网络

-(void)getDrugListWithPage:(NSString *)page isHeader:(BOOL)isHeader
{
    
    GetDrugListService *request = [[GetDrugListService alloc] initWithDocid:DoctorUserDefault.ID page:page];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        NSLog(@"药品列表 %@",request.responseString);
        
        //        if ([request.responseJSONObject isEqual:@1]) {
        DrugsModel *model = [DrugsModel yy_modelWithJSON:request.responseJSONObject];
        
        if (isHeader) {
            
            [self.tableview endHeaderRefreshWithChangePageIndex:YES];
            self.model = model;
            
        }else {
            [self.tableview endFooterRefreshWithChangePageIndex:YES];
            
            if (model.ds.count != 0) {
                [self.model.ds addObjectsFromArray:model.ds];
            }else {
                [self.tableview noMoreData];
            }
        }
        
        [self.tableview reloadData];
        
        //        }else{
        //            if (isHeader) {
        //                [self.tableview endHeaderRefreshWithChangePageIndex:NO];
        //            }else {
        //                [self.tableview endFooterRefreshWithChangePageIndex:NO];
        //            }
        //        }
        
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (isHeader) {
            [self.tableview endHeaderRefreshWithChangePageIndex:NO];
        }else {
            [self.tableview endFooterRefreshWithChangePageIndex:NO];
        }
        NSLog(@"药品列表 %@",request.error);
    }];
    
}



-(void)addDrugWithId:(NSString *)ID sender:(UIButton *)sender
{
    AddMyDrugService *request = [[AddMyDrugService alloc] initWithDocid:DoctorUserDefault.ID medcid:ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        NSLog(@"添加药品 %@",request.responseString);
        
        sender.selected = !sender.selected;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"添加失败" ToView:nil];
        NSLog(@"添加药品 %@",request.error);
    }];
    
    
}



-(void)getDrugListWithKeyWord:(NSString *)keyword Page:(NSString *)page isHeader:(BOOL)isHeader
{
    
    GetDrugListWithKeyWordService *request = [[GetDrugListWithKeyWordService alloc] initWithDocid:DoctorUserDefault.ID page:page keyword:keyword];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        NSLog(@"搜索全部药品 %@",request.responseString);
        DrugsModel *model = [DrugsModel yy_modelWithJSON:request.responseJSONObject];
        
        if (isHeader) {
            
            [self.tableview endHeaderRefreshWithChangePageIndex:YES];
            self.model = model;
            
        }else {
            [self.tableview endFooterRefreshWithChangePageIndex:YES];
            
            if (model.ds.count != 0) {
                [self.model.ds addObjectsFromArray:model.ds];
            }else {
                [self.tableview noMoreData];
            }
        }
        
        [self.tableview reloadData];
        
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (isHeader) {
            [self.tableview endHeaderRefreshWithChangePageIndex:NO];
        }else {
            [self.tableview endFooterRefreshWithChangePageIndex:NO];
        }
        NSLog(@"搜索全部药品 %@",request.error);
    }];
    
    
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.isSearch = NO;
    }else{
        self.isSearch = YES;
    }
    
    [textField resignFirstResponder];
    
    [self.tableview beginHeaderRefresh];
    
    return YES;
}







#pragma mark 懒加载

-(UITextField *)search
{
    if (!_search) {
        
        _search = [[QMUITextField alloc] init];
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
