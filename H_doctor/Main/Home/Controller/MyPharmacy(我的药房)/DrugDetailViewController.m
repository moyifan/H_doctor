//
//  DrugDetailViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "DrugDetailViewController.h"
#import "DrugDetailListTableViewCell.h"
#import "DrugDetailsViewController.h"
#import "UIScrollView+MJRefreshEX.h"

#import "GetDrugListService.h"
#import "DrugListModel.h"
#import "AddMyDrugService.h"
#import "DrugsModel.h"
#import "GetDrugListWithKeyWordService.h"

@interface DrugDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MJRefreshEXDelegate>
@property (nonatomic,strong) UITextField *search;
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) DrugListModel *model;

@property (nonatomic,assign) BOOL isSearch;


@end

@implementation DrugDetailViewController


-(void)setNavBar
{
    [self.navigationView setTitle:@"药品列表"];
    
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



#define Identifier @"DrugDetailListTableViewCell"

-(void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[DrugDetailListTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
    
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.search, 10).rightEqualToView(self.view).bottomEqualToView(self.view);
    

    [tableview addHeaderWithHeaderClass:nil beginRefresh:YES delegate:self animation:YES];
    [tableview addFooterWithFooterClass:nil automaticallyRefresh:YES delegate:self];
    
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


#pragma mark tableviewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ds.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DrugDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    
    cell.model = self.model.ds[indexPath.row];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    
    [cell setAddButtonClickedBlock:^(UIButton *sender) {
        
        [self addDrugWithId:[NSString stringWithFormat:@"%ld",self.model.ds[indexPath.row].ID] sender:sender];
    }];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DrugDetailsViewController *detail = [[DrugDetailsViewController alloc] init];
    detail.model = [Drugs yy_modelWithJSON:[self.model.ds[indexPath.row] yy_modelToJSONObject]];
    [self.navigationController pushViewController:detail animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
    
    return [self.tableview cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView];
    
}




#pragma mark 网络

-(void)getDrugListWithPage:(NSString *)page isHeader:(BOOL)isHeader
{
    
    GetDrugListService *request = [[GetDrugListService alloc] initWithDocid:DoctorUserDefault.ID page:page];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"药品列表 %@",request.responseString);
      
//        if ([request.responseJSONObject isEqual:@1]) {
            DrugListModel *model = [DrugListModel yy_modelWithJSON:request.responseJSONObject];
            
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
        DrugListModel *model = [DrugListModel yy_modelWithJSON:request.responseJSONObject];
        
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
