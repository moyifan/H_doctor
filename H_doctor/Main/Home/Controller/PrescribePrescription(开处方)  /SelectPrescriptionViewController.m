//
//  SelectPrescriptionViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/26.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "SelectPrescriptionViewController.h"
#import "TemplateTableViewCell.h"
#import "AddMedinePrescriptionViewController.h"

@interface SelectPrescriptionViewController ()<UITextFieldDelegate,QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UITextField *search;
@property (nonatomic,strong) QMUITableView *tableview;
@property (nonatomic,strong) UIView *templateView;


@end

@implementation SelectPrescriptionViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"选择处方模板"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = AllBG;
    
    [self setNavBar];
    
    [self setupSearch];
    
    [self setupButton];
    
    [self setupTableView];
    
    
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
    [all setBackgroundImage:[UIImage imageNamed:@"all"] forState:UIControlStateNormal];
    [all setBackgroundImage:[UIImage imageNamed:@"all_icon"] forState:UIControlStateSelected];
    [all sizeToFit];
    [all addTarget:self action:@selector(didClickAll:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *personal = [[UIButton alloc] init];
    [personal setBackgroundImage:[UIImage imageNamed:@"personal"] forState:UIControlStateNormal];
    [personal setBackgroundImage:[UIImage imageNamed:@"personal_icon"] forState:UIControlStateSelected];
    [personal sizeToFit];
    [personal addTarget:self action:@selector(didClickPersonal:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *public = [[UIButton alloc] init];
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
    
    
    
    
    
}


#pragma mark Touch

// 点击全部模板
-(void)didClickAll:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
}

// 个人模板
-(void)didClickPersonal:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    
}

// 公共模板
-(void)didClickPublic:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    
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
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TemplateTableViewCell *cell = [[TemplateTableViewCell alloc] initForTableView:self.tableview withReuseIdentifier:Identifier];
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    cell.edit.hidden = YES;
    cell.delet.hidden = YES;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddMedinePrescriptionViewController *add = [[AddMedinePrescriptionViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
    return 44;
    
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
