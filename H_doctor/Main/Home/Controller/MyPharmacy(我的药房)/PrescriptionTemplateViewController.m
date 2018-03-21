//
//  PrescriptionTemplateViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "PrescriptionTemplateViewController.h"
#import "PrescriptionTemplateTableViewCell.h"
#import "WRCellView.h"
#import "ShuruViewController.h"
#import "AddDrugsSearchViewController.h"
#import "AddDrugsDetailViewController.h"
#import "DiagnosisViewController.h"

#import "NewPrescriptionTemplateService.h"
#import "NewPrescriptionModel.h"
#import "DeleteRecipeTemplateService.h"
#import "SaveAddedRecipeTempletService.h"
#import "GetRecipeTempletChildListByID.h"
#import "UpdateRecipeTempletService.h"
#import "DeleteRecipeChildService.h"

@interface PrescriptionTemplateViewController ()<QMUITableViewDataSource,QMUITableViewDelegate>
@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) UIView *tableFootView;
@property (nonatomic, strong) WRCellView *templateView;
@property (nonatomic, strong) WRCellView *diagnosisView;
@property (nonatomic, strong) WRCellView *rangeView;

@property (nonatomic,strong) QMUITableView *tableview;

@property (nonatomic,strong) NewPrescriptionModel *model;
@property (nonatomic,strong) NSMutableArray *IDarray;
@property (nonatomic,copy) NSString *customText;


@end

@implementation PrescriptionTemplateViewController

-(void)setNavBar
{
    [self.navigationView setTitle:self.titleName];
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.state == NewPre) {
        
        [self getPrescriptiontemplate];
    }else{
        [self getEditPrescriptiontemplate];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    
    [self setupTableHeadView];
    

    [self setupTableView];
    
    [self setupButton];
    
    [self onClickEvent];

    if (self.state == NewPre) {
        
        [self getPrescriptiontemplate];
    }else{
        [self getEditPrescriptiontemplate];
    }
    
}


-(void)setupTableHeadView
{
    _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    _tableHeadView.backgroundColor = AllBG;
    
    // 提示按钮
    UIButton *tip = [[UIButton alloc] init];
    [tip setImage:[UIImage imageNamed:@"tishi"] forState:UIControlStateNormal];
    [tip setTitle:@"通过ICD检索可以与处方模版进行关联" forState:UIControlStateNormal];
    [tip setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    tip.titleLabel.font = PingFangFONT(14);
    [tip lc_imageTitleHorizontalAlignmentWithSpace:5];
    [tip sizeToFit];
    
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
    
    
    [_tableHeadView addSubview:self.templateView];
    [_tableHeadView addSubview:self.diagnosisView];
    [_tableHeadView addSubview:tip];
    [_tableHeadView addSubview:self.rangeView];
    [_tableHeadView addSubview:addView];
    [addView addSubview:tipLabel];
    [addView addSubview:addBtn];
    
    
    self.templateView.sd_layout.leftEqualToView(_tableHeadView).rightEqualToView(_tableHeadView).topEqualToView(_tableHeadView).heightIs(44);
    
    self.diagnosisView.sd_layout.leftEqualToView(_tableHeadView).rightEqualToView(_tableHeadView).topSpaceToView(self.templateView, 10).heightIs(44);
    
    tip.sd_layout.leftSpaceToView(_tableHeadView, 15).topSpaceToView(self.diagnosisView, 10).widthIs(tip.width).heightIs(tip.height);
    
    self.rangeView.sd_layout.leftEqualToView(_tableHeadView).rightEqualToView(_tableHeadView).topSpaceToView(tip, 10).heightIs(44);
    
    addView.sd_layout.leftEqualToView(_tableHeadView).rightEqualToView(_tableHeadView).topSpaceToView(self.rangeView, 0).heightIs(44);
    
    
    tipLabel.sd_layout.leftSpaceToView(addView, 15).centerYEqualToView(addView).heightIs(tipLabel.font.lineHeight);
    [tipLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    addBtn.sd_layout.centerYEqualToView(addView).rightSpaceToView(addView, 15).widthIs(addBtn.width).heightIs(addBtn.height);
    
    
    [addView updateLayout];
    
    _tableHeadView.height = CGRectGetMaxY(addView.frame);
    
}




//
- (void)onClickEvent
{
    __weak typeof(self) weakSelf = self;
  
    self.templateView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        ShuruViewController *shu = [[ShuruViewController alloc] init];
        shu.titleShu = @"模板名称";
        [pThis.navigationController pushViewController:shu animated:YES];
        
        if (!shu.backClickedBlock) {
            [shu setBackClickedBlock:^(NSString *content) {
                
                pThis.templateView.rightLabel.text = content;
                [pThis.templateView layoutSubviews];
                
            }];
        }
        
    };
    
    // 诊断
    self.diagnosisView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        DiagnosisViewController *dia = [[DiagnosisViewController alloc] init];
        [pThis.navigationController pushViewController:dia animated:YES];
        
        if (!dia.ReturnValueBlock) {
            [dia setReturnValueBlock:^(NSMutableArray *array, NSMutableArray *IDarray,NSString *custom) {
                pThis.diagnosisView.rightLabel.text = array[0];
                pThis.IDarray = IDarray;
                pThis.customText = custom;
                [pThis.diagnosisView layoutSubviews];
            }];
        }
        
    };
    
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
    
    [self.view addSubview:tableview];
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, 64).rightEqualToView(self.view).bottomSpaceToView(self.view, 50);
    
    
}




-(void)setupButton
{
    UIButton *new = [[UIButton alloc] init];
    [new setBackgroundImage:[UIImage imageNamed:@"button_sub"] forState:UIControlStateNormal];
    [new setTitle:@"保存模板" forState:UIControlStateNormal];
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
    if (self.state == NewSave) {
        search.state = NewAdd;
    }else{
        search.state = EditAdd;
        search.templetId = [NSString stringWithFormat:@"%ld",self.Recipetmodel.ID];
    }
    [self.navigationController pushViewController:search animated:YES];
}



-(void)didClickSubmit
{
//    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
//    }];
//    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"立即设置" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
//    }];
//    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"尚未设置处方笺手写签名" message:@"是否立即设置？" preferredStyle:QMUIAlertControllerStyleAlert];
//    [alertController addAction:action1];
//    [alertController addAction:action2];
//    [alertController showWithAnimated:YES];
    
    if (self.state == NewPre) {
        
        [self savePrecription];
    }else{
        [self editPrecription];
    }
    
    
}




#pragma mark tableviewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.model.ds.count;

}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    self.tableFootView = footView;
    footView.backgroundColor = [UIColor whiteColor];
    
    CGFloat totalPrice = 0.00f;
    for (PrescriptionDrugs *model in self.model.ds) {
        
        totalPrice += model.price;
        
    }
    
    
    NSString *footText = [NSString stringWithFormat:@"处方总价格: %.2f元",totalPrice];
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
    
    return footView;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44.0f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PrescriptionTemplateTableViewCell *cell = [[PrescriptionTemplateTableViewCell alloc] initForTableView:self.tableview withReuseIdentifier:Identifier];
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    
    [cell.edit addTarget:self action:@selector(didClickEdit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delet addTarget:self action:@selector(didClickDelete:) forControlEvents:UIControlEventTouchUpInside];
  
    

    cell.title.text = self.model.ds[indexPath.row].medcname;
    cell.content.text = [NSString stringWithFormat:@"sig:%@ 用量:%.2f%@",self.model.ds[indexPath.row].yongfa,self.model.ds[indexPath.row].yongliang,self.model.ds[indexPath.row].unit];
    cell.DQ.text = self.model.ds[indexPath.row].pinci;
    cell.detail.text = self.model.ds[indexPath.row].yizhu;
    
    
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
    NSIndexPath *index = [self.tableview qmui_indexPathForRowAtView:sender];

    AddDrugsDetailViewController *detail = [[AddDrugsDetailViewController alloc] init];
    detail.model = self.model.ds[index.row];
    if (self.state == NewPre) {
        detail.isEdit = NO;
        detail.saveState = UpdateSave;

    }else{
        detail.isEdit = YES;
        detail.editSaveState = EditUpdateSave;
    }
    [self.navigationController pushViewController:detail animated:YES];
}


// 删除
-(void)didClickDelete:(UIButton *)sender
{
    
    NSIndexPath *index = [self.tableview qmui_indexPathForRowAtView:sender];
    
    MPWeakSelf(self)
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"删除" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
        if (weakself.state == NewPre) {
            [weakself deleteWithDrug:[NSString stringWithFormat:@"%ld",self.model.ds[index.row].ID]];
        }else{
            [weakself deleteWithRecipe:[NSString stringWithFormat:@"%ld",self.model.ds[index.row].ID]];
        }
    }];
    
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定删除？" message:@"" preferredStyle:QMUIAlertControllerStyleActionSheet];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
}




#pragma mark 网络

-(void)getPrescriptiontemplate
{
    NewPrescriptionTemplateService *request = [[NewPrescriptionTemplateService alloc] initWithDocid:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"新建处方 %@",request.responseString);
        
        self.model = [NewPrescriptionModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@" %@",request.error);
    }];
    
}



// 删除临时
-(void)deleteWithDrug:(NSString *)ID
{
    
    DeleteRecipeTemplateService *request = [[DeleteRecipeTemplateService alloc] initWithDocid:DoctorUserDefault.ID detailid:ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"删除药品 %@",request.responseString);
        
        [self getPrescriptiontemplate];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"删除失败" ToView:nil];
        NSLog(@"删除药品 %@",request.error);
    }];
    
}

// 删除正式
-(void)deleteWithRecipe:(NSString *)ID
{
    
    DeleteRecipeChildService *request = [[DeleteRecipeChildService alloc] initWithDocid:DoctorUserDefault.ID detailid:ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"删除正式药品 %@",request.responseString);
        
        [self getEditPrescriptiontemplate];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"删除失败" ToView:nil];
        NSLog(@"删除药品 %@",request.error);
    }];
    
}



-(void)savePrecription
{
    if ([self.templateView.rightLabel.text isEqualToString:@"请填写处方名称"] ||[self.templateView.rightLabel.text isEqualToString:@""] || self.IDarray == nil || [self.IDarray isEqual: @[]]) {
     
        [MBProgressHUD showError:@"请填写完整信息" ToView:nil];
        return;
    }
    
    
    SaveAddedRecipeTempletService *request = [[SaveAddedRecipeTempletService alloc] initWithDocid:DoctorUserDefault.ID title:self.templateView.rightLabel.text sicknessid:self.IDarray[0] title_diy:self.customText];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"保存模板 %@",request.responseString);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"保存失败" ToView:nil];
        NSLog(@"保存模板 %@",request.error);
    }];
    
    
}



-(void)getEditPrescriptiontemplate
{
    GetRecipeTempletChildListByID *request = [[GetRecipeTempletChildListByID alloc] initWithID:[NSString stringWithFormat:@"%ld",self.Recipetmodel.ID]];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"获得编辑模板 %@",request.responseString);
        
        self.model = [NewPrescriptionModel yy_modelWithJSON:request.responseJSONObject];
        
        [self.tableview reloadData];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"获得编辑模板 %@",request.error);
    }];
    
}



-(void)editPrecription
{
    if ([self.templateView.rightLabel.text isEqualToString:@"请填写处方名称"] ||[self.templateView.rightLabel.text isEqualToString:@""] || self.IDarray == nil || [self.IDarray isEqual: @[]]) {
        
        [MBProgressHUD showError:@"请填写完整信息" ToView:nil];
        return;
    }
    
    
    UpdateRecipeTempletService *request = [[UpdateRecipeTempletService alloc] initWithDocid:DoctorUserDefault.ID   ID:[NSString stringWithFormat:@"%ld",self.Recipetmodel.ID] title:self.templateView.rightLabel.text sicknessid:self.IDarray[0] title_diy:self.customText];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"保存编辑模板 %@",request.responseString);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"保存失败" ToView:nil];
        NSLog(@"保存编辑模板 %@",request.error);
    }];
    
}




#pragma mark 懒加载


-(WRCellView *)templateView
{
    if (!_templateView) {
        
        _templateView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _templateView.leftLabel.text = @"模板名称";
        if (self.state == NewPre) {
            _templateView.rightLabel.text = @"请填写处方名称";
        }else{
            _templateView.rightLabel.text = self.Recipetmodel.title;
        }
        
        [_templateView setHideBottomLine:YES];
    }
    
    return _templateView;
}


-(WRCellView *)diagnosisView
{
    if (!_diagnosisView) {
        
        _diagnosisView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _diagnosisView.leftLabel.text = @"诊断名称";
        if (self.state == NewPre) {
            _diagnosisView.rightLabel.text = @"";
        }else{
            _diagnosisView.rightLabel.text = self.Recipetmodel.sicknessname;
            [self.IDarray addObject:[NSString stringWithFormat:@"%ld",self.Recipetmodel.sicknessid]];
            self.customText = self.Recipetmodel.title_diy;
        }
        [_diagnosisView setHideBottomLine:YES];

    }
    
    return _diagnosisView;
}


-(WRCellView *)rangeView
{
    if (!_rangeView) {
        
        _rangeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _rangeView.leftLabel.text = @"适用范围";
        _rangeView.rightLabel.text = @"个人模板";
        _rangeView.userInteractionEnabled = NO;
        [_rangeView setHideBottomLine:YES];
        
    }
    
    return _rangeView;
}

-(NSMutableArray *)IDarray
{
    if (!_IDarray) {
        _IDarray = [NSMutableArray array];
    }
    return _IDarray;
}


@end
