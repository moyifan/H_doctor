//
//  PrescribePrescriptionViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/25.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "PrescribePrescriptionViewController.h"
#import "PrescribePrescriptionTableViewCell.h"
#import "AddMedinePrescriptionViewController.h"
#import "SelectPrescriptionViewController.h"
#import "AnaphylaxisViewController.h"
#import "PrescriptionDetailViewController.h"

@interface PrescribePrescriptionViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,strong) NSMutableArray *footArray;

@end

@implementation PrescribePrescriptionViewController


-(void)setNavBar
{
    [self.navigationView setTitle:@"开处方"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"提交" clickCallBack:^(UIView *view) {
        
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor  = AllBG;
    
    [self setNavBar];
    
    [self setupSubViews];
    

}

#define Identifier @"PrescribePrescriptionTableViewCell"

-(void)setupSubViews
{

    
    QMUITableView *tableview = [[QMUITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[PrescribePrescriptionTableViewCell class] forCellReuseIdentifier:Identifier];

    tableview.tableHeaderView = [self tableHeadView];
    tableview.tableFooterView = [self tableFootView];

    __weak typeof(self) weakSelf = self;
    [self.headerView setDidFinishAutoLayoutBlock:^(CGRect frame){
        
        weakSelf.headerView.frame = frame;
        [weakSelf.tableview setTableHeaderView:weakSelf.headerView];
        
    }];
    
    [self.footerView setDidFinishAutoLayoutBlock:^(CGRect frame){
        
        weakSelf.footerView.frame = frame;
        [weakSelf.tableview setTableFooterView:weakSelf.footerView];
        
    }];
    
    
    [self.view addSubview:tableview];
    
    tableview.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).bottomSpaceToView(self.view, 50);
    
    
    
    // toolBar
    QMUIButton *add = [[QMUIButton alloc] qmui_initWithImage:nil title:@"添加药品"];
    [add setBackgroundColor:[UIColor whiteColor]];
    [add setTitleColor:RGB(72, 147, 245) forState:UIControlStateNormal];
    add.titleLabel.font = PingFangFONT(18);
    [add addTarget:self action:@selector(didClickAdd) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *use = [[QMUIButton alloc] qmui_initWithImage:nil title:@"使用处方模板"];
    [use setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [use setBackgroundImage:[UIImage imageNamed:@"button_sub"] forState:UIControlStateNormal];
    use.titleLabel.font = PingFangFONT(18);
    [use addTarget:self action:@selector(didClickUse) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:add];
    [self.view addSubview:use];
    
    add.sd_layout.leftEqualToView(self.view).bottomEqualToView(self.view).widthIs(self.view.width/2).heightIs(50);
    use.sd_layout.rightEqualToView(self.view).bottomEqualToView(self.view).widthIs(self.view.width/2).heightIs(50);
    
    
}

//
-(void)didClickAdd
{
    AddMedinePrescriptionViewController *add = [[AddMedinePrescriptionViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
    
}


-(void)didClickUse
{
    SelectPrescriptionViewController *select = [[SelectPrescriptionViewController alloc] init];
    [self.navigationController pushViewController:select animated:YES];
    
}



-(UIView *)tableHeadView
{
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = AllBG;
    
    // dataView
    UIView *dataView = [[UIView alloc] init];
    dataView.backgroundColor = [UIColor whiteColor];
    
    
    QMUILabel *name = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    name.text = @"真实姓名：黄晓晓";
    
    QMUILabel *sex = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    sex.text = @"性别：      男";
    
    QMUILabel *age = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    age.text = @"年龄：      19岁";
    
    QMUILabel *marry = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    marry.text = @"婚姻：      未知";
    
    QMUILabel *phone = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    phone.text = @"手机号：   13888888888";
    
    QMUILabel *IDCard = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    IDCard.text = @"身份证号：4222202222222222";
    
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 45;
    icon.layer.masksToBounds = YES;
    icon.image = [UIImage imageNamed:@"header_icon_line"];
    
    [self.headerView addSubview:dataView];
    [dataView addSubview:name];
    [dataView addSubview:sex];
    [dataView addSubview:age];
    [dataView addSubview:marry];
    [dataView addSubview:phone];
    [dataView addSubview:IDCard];
    [dataView addSubview:icon];
    
    
    
    dataView.sd_layout.leftSpaceToView(self.headerView, 15).rightSpaceToView(self.headerView, 15).topSpaceToView(self.headerView, 16);
    
    name.sd_layout.leftSpaceToView(dataView, 18).topSpaceToView(dataView, 20).heightIs(name.font.lineHeight);
    [name setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    sex.sd_layout.leftEqualToView(name).topSpaceToView(name, 14).heightIs(sex.font.lineHeight);
    [sex setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    age.sd_layout.leftEqualToView(name).topSpaceToView(sex, 14).heightIs(age.font.lineHeight);
    [age setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    marry.sd_layout.leftEqualToView(name).topSpaceToView(age, 14).heightIs(marry.font.lineHeight);
    [marry setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    phone.sd_layout.leftEqualToView(name).topSpaceToView(marry, 14).heightIs(phone.font.lineHeight);
    [phone setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    IDCard.sd_layout.leftEqualToView(name).topSpaceToView(phone, 14).heightIs(IDCard.font.lineHeight);
    [IDCard setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    icon.sd_layout.rightSpaceToView(dataView, 17).topSpaceToView(dataView, 19).widthIs(90).heightIs(90);
    
    [dataView setupAutoHeightWithBottomView:IDCard bottomMargin:20];
    
    [self.headerView setupAutoHeightWithBottomView:dataView bottomMargin:15];
    
    return self.headerView;
}


-(UIView *)tableFootView
{
    UIView *footView = [[UIView alloc] init];
    self.footerView = footView;
    footView.backgroundColor = [UIColor whiteColor];
    
    QMUILabel *title = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkQianColor];
    title.text = @"电子处方（开具处方前要先填写诊断）";
    
    [footView addSubview:title];
    
    title.sd_layout.leftSpaceToView(footView, 17).topSpaceToView(footView, 15).heightIs(title.font.lineHeight);
    [title setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    QMUIFloatLayoutView *btnView = [[QMUIFloatLayoutView alloc] init];
    btnView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    btnView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    btnView.minimumItemSize = CGSizeMake(69, 29);// 以2个字的按钮作为最小宽度
    NSArray<NSString *> *keshi = @[@"(西)20171109142406191", @"(东)20171109142406191"];
    for (NSInteger i = 0; i < keshi.count; i++) {
        QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
        button.ghostColor = darkQianColor;
        [button setTitle:keshi[i] forState:UIControlStateNormal];
        button.titleLabel.font = PingFangFONT(13);
        button.contentEdgeInsets = UIEdgeInsetsMake(7, 15, 7, 15);
        [button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
       

        [btnView addSubview:button];
    }
    
    [footView addSubview:btnView];
    
    CGSize keshiSize = [btnView sizeThatFits:CGSizeMake(self.view.width-30, CGFLOAT_MAX)];
    btnView.sd_layout.leftSpaceToView(footView, 15).rightSpaceToView(footView, 15).topSpaceToView(title, 0).heightIs(keshiSize.height);
    
    [footView setupAutoHeightWithBottomView:btnView bottomMargin:15];
    
    return footView;
    
    
}


-(void)didClickBtn:(UIButton *)sender
{
    PrescriptionDetailViewController *detail = [[PrescriptionDetailViewController alloc] init];
    detail.title = @"(西)20171109142406191";
    [self.navigationController pushViewController:detail animated:YES];
}



/**
 *  数据源
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PrescribePrescriptionTableViewCell *cell = [[PrescribePrescriptionTableViewCell alloc] initForTableView:self.tableview withReuseIdentifier:Identifier];
    
    [cell updateCellAppearanceWithIndexPath:indexPath];


    
    if (indexPath.row == 0) {
        cell.title.text = @"就诊时间：";
        cell.detail.text = @"2017-11-13 14:05";
        cell.edit.hidden = YES;
    } else if (indexPath.row == 1) {
        cell.title.text = @"体重(kg)：";
        cell.detail.text = @"45.0";
    } else if (indexPath.row == 2) {
        cell.title.text = @"主诉：";
        cell.detail.text = @"整个人不太好";
    } else if (indexPath.row == 3) {
        cell.title.text = @"药物过敏史：";
        cell.detail.text = @"花粉";
    }else{
        cell.title.text = @"诊断：";
        cell.detail.text = @"维生素B6缺乏";
    }
    
    
    [cell.edit addTarget:self action:@selector(didClickEdit:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
}



// 编辑
-(void)didClickEdit:(UIButton *)sender
{
    NSIndexPath *index =  [self.tableview qmui_indexPathForRowAtView:sender];
    
    if (index.row == 1) {
        
    }else if (index.row == 2){
        
        
    }else if (index.row == 3){
        AnaphylaxisViewController *anaphy = [[AnaphylaxisViewController alloc] init];
        [self.navigationController pushViewController:anaphy animated:YES];
    }else{
        
        
    }
    
}



@end
