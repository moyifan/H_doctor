//
//  AddMedinePrescriptionViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/26.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AddMedinePrescriptionViewController.h"
#import "PrescriptionTemplateTableViewCell.h"
#import "AddDrugsSearchViewController.h"
#import "AddDrugsDetailViewController.h"

@interface AddMedinePrescriptionViewController ()<QMUITableViewDataSource,QMUITableViewDelegate>
@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) UIView *tableFootView;

@property (nonatomic,strong) QMUITableView *tableview;

@end

@implementation AddMedinePrescriptionViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"添加处方药"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    
    [self setupTableHeadView];
    
    [self setupTableFootView];
    
    [self setupTableView];
    
    [self setupButton];
    
}


-(void)setupTableHeadView
{
    _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    _tableHeadView.backgroundColor = AllBG;
    
    
    // 添加药品View
    UIView *addView = [[UIView alloc] init];
    addView.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = PingFangFONT(16);
    tipLabel.textColor = darkShenColor;
    tipLabel.text = @"已开西药处方：";
    
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add_drug_icon_"] forState:UIControlStateNormal];
    [addBtn sizeToFit];
    [addBtn addTarget:self action:@selector(didClickAdd) forControlEvents:UIControlEventTouchUpInside];
    

    [_tableHeadView addSubview:addView];
    [addView addSubview:tipLabel];
    [addView addSubview:addBtn];
    
    
    addView.sd_layout.leftEqualToView(_tableHeadView).rightEqualToView(_tableHeadView).topSpaceToView(_tableview, 0).heightIs(44);
    
    
    tipLabel.sd_layout.leftSpaceToView(addView, 15).centerYEqualToView(addView).heightIs(tipLabel.font.lineHeight);
    [tipLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    addBtn.sd_layout.centerYEqualToView(addView).rightSpaceToView(addView, 15).widthIs(addBtn.width).heightIs(addBtn.height);
    
    
    [addView updateLayout];
    
    _tableHeadView.height = CGRectGetMaxY(addView.frame);
    
}




-(void)setupTableFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    self.tableFootView = footView;
    footView.backgroundColor = [UIColor whiteColor];
    
    NSString *footText = @"处方总价格: 8888.80元";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:footText];
    
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(16) range:NSMakeRange(0, 7)];
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(16) range:NSMakeRange(footText.length-1, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:darkShenColor range:NSMakeRange(0, 7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:darkShenColor range:NSMakeRange(footText.length-1, 1)];
    
    //8888-80 text-style1
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(23) range:NSMakeRange(7, footText.length-8)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, footText.length-8)];
    
    
    UILabel *price = [[UILabel alloc] init];
    price.attributedText = attributedString;
    
    [footView addSubview:price];
    
    price.sd_layout.topSpaceToView(footView, 5).rightSpaceToView(footView, 15).heightIs(price.font.lineHeight);
    price.isAttributedContent = YES;
    [price setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    
}



#define Identifier @"PrescriptionTemplateTableViewCell"

-(void)setupTableView
{
    QMUITableView *tableview = [[QMUITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[PrescriptionTemplateTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [tableview setTableHeaderView:self.tableHeadView];
    [tableview setTableFooterView:self.tableFootView];
    
    [self.view addSubview:tableview];
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, 64).rightEqualToView(self.view).bottomSpaceToView(self.view, 50);
    
    
}




-(void)setupButton
{
    UIButton *new = [[UIButton alloc] init];
    [new setBackgroundImage:[UIImage imageNamed:@"button_sub"] forState:UIControlStateNormal];
    [new setTitle:@"生成处方" forState:UIControlStateNormal];
    [new setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    new.titleLabel.font = PingFangFONT(18);
    [new addTarget:self action:@selector(didClickSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:new];
    
    new.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
}


#pragma mark touch

-(void)didClickAdd
{
    AddDrugsSearchViewController *search = [[AddDrugsSearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}


// 生成处方
-(void)didClickSubmit
{
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"立即设置" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"尚未设置处方笺手写签名" message:@"是否立即设置？" preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}




#pragma mark tableviewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PrescriptionTemplateTableViewCell *cell = [[PrescriptionTemplateTableViewCell alloc] initForTableView:self.tableview withReuseIdentifier:Identifier];
    
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
    
    return [self.tableview cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView];
    
}


// 编辑
-(void)didClickEdit:(UIButton *)sender
{
    AddDrugsDetailViewController *detail = [[AddDrugsDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}


// 删除
-(void)didClickDelete:(UIButton *)sender
{
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"删除" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定删除？" message:@"" preferredStyle:QMUIAlertControllerStyleActionSheet];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
}




@end
