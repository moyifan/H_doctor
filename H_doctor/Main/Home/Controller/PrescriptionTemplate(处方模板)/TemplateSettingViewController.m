//
//  TemplateSettingViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "TemplateSettingViewController.h"
#import "TemplateTableViewCell.h"

#import "PrescriptionTemplateViewController.h"
#import "GetRecipeTempletService.h"
#import "RecipeTempletModel.h"
#import "GetRecipeTempletByKeywordService.h"
#import "PrescriptionTemplateViewController.h"
#import "DeleteRecipeService.h"

@interface TemplateSettingViewController ()<UITextFieldDelegate,QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UITextField *search;
@property (nonatomic,strong) QMUITableView *tableview;
@property (nonatomic,strong) UIView *templateView;

@property (nonatomic,strong) RecipeTempletModel *model;

@end

@implementation TemplateSettingViewController
{
    UIButton *_all;
    UIButton *_personal;
    UIButton *_public;

}

-(void)setNavBar
{
    [self.navigationView setTitle:@"设置处方模板"];
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *type;
    if (_all.selected == YES) {
        type = @"0";
    }else if (_personal.selected == YES){
        type = @"1";
    }else{
        type = @"2";
    }
    
    [self GetRecipeTempletWithType:type];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = AllBG;

    [self setNavBar];
    
    [self setupSearch];
    
    [self setupButton];
    
    [self setupTableView];
    
    [self GetRecipeTempletWithType:@"0"];

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




-(void)setupButton
{
    //模板分类
    UIView *templateView = [[UIView alloc] init];
    self.templateView = templateView;
    templateView.backgroundColor = [UIColor whiteColor];
    
    
    QMUILabel *templateLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    templateLabel.text = @"模板分类:";
    
    UIButton *all = [[UIButton alloc] init];
    _all = all;
    [all setBackgroundImage:[UIImage imageNamed:@"all"] forState:UIControlStateNormal];
    [all setBackgroundImage:[UIImage imageNamed:@"all_icon"] forState:UIControlStateSelected];
    [all sizeToFit];
    [all addTarget:self action:@selector(didClickAll:) forControlEvents:UIControlEventTouchUpInside];
    all.selected = YES;
    
    UIButton *personal = [[UIButton alloc] init];
    _personal = personal;
    [personal setBackgroundImage:[UIImage imageNamed:@"personal"] forState:UIControlStateNormal];
    [personal setBackgroundImage:[UIImage imageNamed:@"personal_icon"] forState:UIControlStateSelected];
    [personal sizeToFit];
    [personal addTarget:self action:@selector(didClickPersonal:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *public = [[UIButton alloc] init];
    _public = public;
    [public setBackgroundImage:[UIImage imageNamed:@"public"] forState:UIControlStateNormal];
    [public setBackgroundImage:[UIImage imageNamed:@"public_select"] forState:UIControlStateSelected];
    [public sizeToFit];
    [public addTarget:self action:@selector(didClickPublic:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:templateView];
    [templateView addSubview:templateLabel];
    [templateView addSubview:all];
    [templateView addSubview:personal];
    [templateView addSubview:public];

    
    templateView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.searchView, 10).heightIs(44);
    
    templateLabel.sd_layout.leftSpaceToView(templateView, 15).centerYEqualToView(templateView).heightIs(templateLabel.font.lineHeight);
    [templateLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    all.sd_layout.leftSpaceToView(templateLabel, 24).centerYEqualToView(templateLabel).widthIs(all.width).heightIs(all.height);
    
    personal.sd_layout.leftSpaceToView(all, 13).centerYEqualToView(all).widthIs(personal.width).heightIs(personal.height);

    public.sd_layout.leftSpaceToView(personal, 13).centerYEqualToView(personal).widthIs(public.width).heightIs(public.height);

    
    
    
    
    // 新建处方模板btn
    QMUIButton *add = [[QMUIButton alloc] init];
    [add setBackgroundImage:[UIImage imageNamed:@"button_sub"] forState:UIControlStateNormal];
    [add setTitle:@"新建处方模板" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    add.titleLabel.font = PingFangFONT(18);
    [add addTarget:self action:@selector(didClickAdd) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:add];

    add.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
}


#pragma mark Touch
// 新建处方模板
-(void)didClickAdd
{
    PrescriptionTemplateViewController *pre = [[PrescriptionTemplateViewController alloc] init];
    pre.titleName = @"新建处方模板";
    pre.state = NewPre;
    [self.navigationController pushViewController:pre animated:YES];
}

// 点击全部模板
-(void)didClickAll:(UIButton *)sender
{
    _all.selected = YES;
    _personal.selected = _public.selected = NO;
    
    [self GetRecipeTempletWithType:@"0"];

}

// 个人模板
-(void)didClickPersonal:(UIButton *)sender
{
    _personal.selected = YES;
    _all.selected = _public.selected = NO;
    
    [self GetRecipeTempletWithType:@"1"];
    
}

// 公共模板
-(void)didClickPublic:(UIButton *)sender
{
    _public.selected = YES;
    _all.selected = _personal.selected = NO;
    
    [self GetRecipeTempletWithType:@"2"];
    
}




#define Identifier @"TemplateTableViewCell"

-(void)setupTableView
{
    QMUITableView *tableview = [[QMUITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[TemplateTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
    
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.templateView, 10).rightEqualToView(self.view).bottomSpaceToView(self.view, 50);
    
    
}




#pragma mark tableviewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ds.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TemplateTableViewCell *cell = [[TemplateTableViewCell alloc] initForTableView:self.tableview withReuseIdentifier:Identifier];
    
    cell.model = self.model.ds[indexPath.row];
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    
    [cell.edit addTarget:self action:@selector(didClickEdit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delet addTarget:self action:@selector(didClickDelete:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
    return 44;
    
}




// 编辑
-(void)didClickEdit:(UIButton *)sender
{
    NSIndexPath *index = [self.tableview qmui_indexPathForRowAtView:sender];

    PrescriptionTemplateViewController *pre = [[PrescriptionTemplateViewController alloc] init];
    pre.titleName = self.model.ds[index.row].title;
    pre.state = EditPre;
    pre.Recipetmodel = self.model.ds[index.row];
    [self.navigationController pushViewController:pre animated:YES];
}


// 删除
-(void)didClickDelete:(UIButton *)sender
{
    NSIndexPath *index = [self.tableview qmui_indexPathForRowAtView:sender];

    MPWeakSelf(self)
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"删除" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
        [weakself deleteWithID:[NSString stringWithFormat:@"%ld",self.model.ds[index.row].ID]];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定删除？" message:@"" preferredStyle:QMUIAlertControllerStyleActionSheet];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
}





#pragma mark 网络

-(void)GetRecipeTempletWithType:(NSString *)type
{
    GetRecipeTempletService *request = [[GetRecipeTempletService alloc] initWithDocid:DoctorUserDefault.ID type:type];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"获得模板 %@",request.responseString);
        
        self.model = [RecipeTempletModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"获得模板 %@",request.error);
    }];
    
}


-(void)deleteWithID:(NSString *)ID
{
    DeleteRecipeService *request = [[DeleteRecipeService alloc] initWithDocid:DoctorUserDefault.ID templetid:ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"删除模板 %@",request.responseString);
        
        NSString *type;
        if (_all.selected == YES) {
            type = @"0";
        }else if (_personal.selected == YES){
            type = @"1";
        }else{
            type = @"2";
        }
        
        [self GetRecipeTempletWithType:type];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"删除失败" ToView:nil];
        NSLog(@"删除模板 %@",request.error);
    }];
    
}



-(void)SearchRecipeTemplet
{
    [self.search resignFirstResponder];
  
    
    NSString *type;
    if (_all.selected == YES) {
        type = @"0";
    }else if (_personal.selected == YES){
        type = @"1";
    }else{
        type = @"2";
    }
    
    
    GetRecipeTempletByKeywordService *request = [[GetRecipeTempletByKeywordService alloc] initWithDocid:DoctorUserDefault.ID type:type keyword:self.search.text];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"搜索模板 %@",request.responseString);
        self.model = [RecipeTempletModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        
        self.search.text = @"";

        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"搜索模板 %@",request.error);
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [self SearchRecipeTemplet];
    
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
        _search.placeholder = @"请输入您要搜索的模板名称";
        _search.textColor = darkShenColor;
        _search.font = PingFangFONT(14);
        _search.delegate = self;
        _search.returnKeyType = UIReturnKeySearch;
        
    }
    
    return _search;
}



@end
