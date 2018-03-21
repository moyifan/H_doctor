//
//  AddDrugsDetailViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AddDrugsDetailViewController.h"
#import "PrescriptionTemplateViewController.h"
#import "WRCellView.h"
#import "ShuruViewController.h"

#import "AddRecipeTempletChild_TempService.h"
#import "UpdateRecipeTempletChild_TempService.h"
#import "UpdateRecipeTempletChildService.h"
#import "AddRecipeTempletChildService.h"

@interface AddDrugsDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scollView;
@property (nonatomic, strong) WRCellView *nameView;
@property (nonatomic, strong) WRCellView *specificationsView;

@property (nonatomic, strong) UIView *usageView;  // 用法
@property (nonatomic, strong) QMUITextView *usageTextView;

@property (nonatomic, strong) WRCellView *frequencyView;
@property (nonatomic, strong) WRCellView *daysView;
@property (nonatomic, strong) WRCellView *countView;
@property (nonatomic, strong) WRCellView *useView;

@property (nonatomic, strong) UIView *entrustView;  // 嘱托
@property (nonatomic, strong) QMUITextView *entrustTextView;

@end

@implementation AddDrugsDetailViewController
{
    QMUITextField *_amountCount;
    QMUILabel *_mg;
    CGFloat _amountFloat;
}

-(void)setNavBar
{
    [self.navigationView setTitle:@"添加药品"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"保存" clickCallBack:^(UIView *view) {
        
        if (self.isEdit == NO) {
            
            if (self.saveState == NewSave) {
                
                [weakself postPrescriptionTemp];
                
            }else{
                [weakself updatePrescriptionTemp];
                
            }
            
        }else{
            
            if (self.editSaveState == EditNewSave) {
                
                [weakself postPrescription];
                
            }else{
                [weakself updatePrescription];
                
            }
            
        }
        
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = AllBG;
    
    [self setNavBar];

    [self setupScorllView];
    
    [self setupSubViews];
    
    [self onClickEvent];

}


-(void)setupScorllView
{
    
    UIScrollView *scoll = [[UIScrollView alloc] init];
    _scollView = scoll;
    scoll.showsVerticalScrollIndicator = NO;
    scoll.delegate = self;
    //    scoll.bounces = NO;
    
    
    [self.view addSubview:scoll];
    scoll.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).bottomEqualToView(self.view);
    
}


-(void)setupSubViews
{
    
    // 用法
    _usageView = [[UIView alloc] init];
    _usageView.backgroundColor = [UIColor whiteColor];
    
    QMUILabel *usageLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    usageLabel.text = @"药品用法";
    
    
    _usageTextView = [[QMUITextView alloc] init];
    _usageTextView.layer.borderColor = lineBG.CGColor;
    _usageTextView.layer.borderWidth = 1;
    _usageTextView.layer.cornerRadius = 3;
    _usageTextView.layer.masksToBounds = YES;
//    _usageTextView.placeholder = @"请输入用餐前还是用餐后服用，服用几片计量，吞服或是咀嚼服用等。";
    _usageTextView.placeholderColor = darkQianColor;
    _usageTextView.font = PingFangFONT(14);
    _usageTextView.maximumTextLength = 1000;
    _usageTextView.text = self.model.usage;
    _usageTextView.editable = NO;

    
    QMUILabel *amountUse = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    amountUse.text = @"药品用量";
    
    QMUIButton *minus = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"minus_icon"] title:nil];
    [minus setBackgroundColor:RGB(245, 245, 245)];
    [minus addTarget:self action:@selector(didClickmin) forControlEvents:UIControlEventTouchUpInside];
    
    
    QMUITextField *amountCount = [[QMUITextField alloc] init];
    _amountCount = amountCount;
    amountCount.font = PingFangFONT(16);
    amountCount.textColor = darkShenColor;
    amountCount.text = [NSString stringWithFormat:@"%.2f",self.model.yongliang];
    amountCount.backgroundColor = RGB(245, 245, 245);
    amountCount.textAlignment = NSTextAlignmentCenter;
    amountCount.keyboardType = UIKeyboardTypeDecimalPad;
    amountCount.maximumTextLength = 5;
    //
    _amountFloat = 0.00;
    
    
    QMUIButton *maxus = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"plus_icon"] title:nil];
    [maxus setBackgroundColor:RGB(245, 245, 245)];
    [maxus addTarget:self action:@selector(didClickmax) forControlEvents:UIControlEventTouchUpInside];

    
    QMUILabel *mg = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    _mg = mg;
    mg.text = self.model.unit;
    mg.backgroundColor = RGB(245, 245, 245);
    mg.textAlignment = NSTextAlignmentCenter;
    
    
    // 嘱托
    _entrustView = [[UIView alloc] init];
    _entrustView.backgroundColor = [UIColor whiteColor];
    
    
    QMUILabel *entrustLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    entrustLabel.text = @"嘱托";
    
    
    _entrustTextView = [[QMUITextView alloc] init];
    _entrustTextView.layer.borderColor = lineBG.CGColor;
    _entrustTextView.layer.borderWidth = 1;
    _entrustTextView.layer.cornerRadius = 3;
    _entrustTextView.layer.masksToBounds = YES;
    _entrustTextView.placeholder = @"请按药品说明书或者医生嘱托下购买和使用";
    _entrustTextView.placeholderColor = darkQianColor;
    _entrustTextView.font = PingFangFONT(14);
    _entrustTextView.maximumTextLength = 1000;

    
    
    //布局
    [self.scollView addSubview:self.nameView];
    [self.scollView addSubview:self.specificationsView];
    [self.scollView addSubview:_usageView];
    [self.scollView addSubview:_entrustView];
    
    //
    [_usageView addSubview:usageLabel];
    [_usageView addSubview:_usageTextView];
    [_usageView addSubview:amountUse];
    [_usageView addSubview:minus];
    [_usageView addSubview:amountCount];
    [_usageView addSubview:maxus];
    [_usageView addSubview:mg];

    
    // 频次等
    [self.scollView addSubview:self.frequencyView];
    [self.scollView addSubview:self.daysView];
    [self.scollView addSubview:self.countView];
    [self.scollView addSubview:self.useView];
    
    // 嘱托
    [_entrustView addSubview:entrustLabel];
    [_entrustView addSubview:_entrustTextView];
    
    
    self.nameView.sd_layout.topSpaceToView(_scollView, 10).leftEqualToView(_scollView).rightEqualToView(_scollView).heightIs(44);
    
    self.specificationsView.sd_layout.topSpaceToView(_nameView, 0).leftEqualToView(_scollView).rightEqualToView(_scollView).heightIs(44);
    
    // 用法
    _usageView.sd_layout.leftEqualToView(_scollView).rightEqualToView(_scollView).topSpaceToView(_specificationsView, 10);
    
    usageLabel.sd_layout.leftSpaceToView(_usageView, 16).topSpaceToView(_usageView, 18).heightIs(usageLabel.font.lineHeight);
    [usageLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    _usageTextView.sd_layout.topSpaceToView(usageLabel, 10).leftSpaceToView(_usageView, 15).rightSpaceToView(_usageView, 15).heightIs(90);
    
    amountUse.sd_layout.topSpaceToView(_usageTextView, 26).leftSpaceToView(_usageView, 16).heightIs(amountUse.font.lineHeight);
    [amountUse setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    minus.sd_layout.centerYEqualToView(amountUse).leftSpaceToView(amountUse, 40).widthIs(32).heightIs(30);
    
    amountCount.sd_layout.centerYEqualToView(minus).leftSpaceToView(minus, 2).widthIs(63).heightIs(30);
    
    maxus.sd_layout.centerYEqualToView(amountUse).leftSpaceToView(amountCount, 2).widthIs(32).heightIs(30);
    
    mg.sd_layout.centerYEqualToView(amountUse).rightSpaceToView(_usageView, 36).widthIs(63).heightIs(30);
    
    [_usageView setupAutoHeightWithBottomView:amountUse bottomMargin:28];
    
    
    
    // 频次等
    self.frequencyView.sd_layout.topSpaceToView(_usageView, 10).leftEqualToView(_scollView).rightEqualToView(_scollView).heightIs(44);
    
    self.daysView.sd_layout.topSpaceToView(_frequencyView, 0).leftEqualToView(_scollView).rightEqualToView(_scollView).heightIs(44);
    
    self.countView.sd_layout.topSpaceToView(_daysView, 0).leftEqualToView(_scollView).rightEqualToView(_scollView).heightIs(44);
    
    self.useView.sd_layout.topSpaceToView(_countView, 0).leftEqualToView(_scollView).rightEqualToView(_scollView).heightIs(44);
    
    
    
    //嘱托
    
    _entrustView.sd_layout.leftEqualToView(_scollView).rightEqualToView(_scollView).topSpaceToView(_useView, 10);
    
    entrustLabel.sd_layout.leftSpaceToView(_entrustView, 16).topSpaceToView(_entrustView, 16).heightIs(entrustLabel.font.lineHeight);
    [entrustLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    _entrustTextView.sd_layout.topSpaceToView(entrustLabel, 10).leftSpaceToView(_entrustView, 15).rightSpaceToView(_entrustView, 15).heightIs(90);
    
    [_entrustView setupAutoHeightWithBottomView:_entrustTextView bottomMargin:24];
    
    
    [self.scollView setupAutoContentSizeWithBottomView:_entrustView bottomMargin:0];

}




- (void)onClickEvent
{
    __weak typeof(self) weakSelf = self;
//    self.nameView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
//
//    };
    
    self.frequencyView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis showNormalSelectionDialogViewController:pThis.frequencyView];
    };
    
    self.daysView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis showNormalSelectionDialogViewController:pThis.daysView];
    };
    
    self.countView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        ShuruViewController *shu = [[ShuruViewController alloc] init];
        shu.title = @"数量";
        [pThis.navigationController pushViewController:shu animated:YES];
        
        if (!shu.backClickedBlock) {
            [shu setBackClickedBlock:^(NSString *content) {
                pThis.countView.rightLabel.text = content;
                [pThis.countView layoutSubviews];
            }];
        }
    };
    
    self.useView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis showNormalSelectionDialogViewController:pThis.useView];
    };
    
}

// 减号
-(void)didClickmin
{
    _amountFloat--;
    if (_amountFloat < 0.00) {
        _amountFloat = 0.00;
    }
    _amountCount.text = [NSString stringWithFormat:@"%.2f",_amountFloat];
}

// 加号
-(void)didClickmax
{
    _amountFloat++;
    _amountCount.text = [NSString stringWithFormat:@"%.2f",_amountFloat];
    
}


// 展示一个选择器
- (void)showNormalSelectionDialogViewController:(WRCellView *)cellView {
    QMUIDialogSelectionViewController *dialogViewController = [[QMUIDialogSelectionViewController alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    if (cellView == self.frequencyView) {
        dialogViewController.title = @"频次";
        [array addObjectsFromArray: @[@"QD | 一天一次", @"BID | 一天两次", @"TID | 一天三次", @"QID | 一天四次",@"QOD | 隔天一次",@"QH | 每1小时一次",@"Q2H | 每2小时一次",@"Q3H | 每3小时一次",@"Q4H | 每4小时一次",@"Q6H | 每6小时一次",@"Q8H | 每8小时一次",@"Q12H | 每12小时一次",@"night | 每晚一次",@"biw | 每周两次",@"qw | 每周一次",@"prn | 必要时"]];
    }else if (cellView == self.daysView){
        dialogViewController.title = @"天数";
        for (int i = 1; i<31; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }else if(cellView == self.useView){
        dialogViewController.title = @"用法";
        [array addObjectsFromArray: @[@"口服", @"外用", @"冲服", @"含服",@"肛塞",@"漱口",@"含漱",@"滴耳",@"滴眼",@"吸入",@"喷鼻"]];
        
    }
    
    
    dialogViewController.items = array;
    dialogViewController.cellForItemBlock = ^(QMUIDialogSelectionViewController *aDialogViewController, QMUITableViewCell *cell, NSUInteger itemIndex) {
        cell.accessoryType = UITableViewCellAccessoryNone;// 移除点击时默认加上右边的checkbox
    };
    dialogViewController.heightForItemBlock = ^CGFloat (QMUIDialogSelectionViewController *aDialogViewController, NSUInteger itemIndex) {
        return 44;// 修改默认的行高，默认为 TableViewCellNormalHeight
    };
    dialogViewController.didSelectItemBlock = ^(QMUIDialogSelectionViewController *aDialogViewController, NSUInteger itemIndex) {
        [aDialogViewController hide];
        cellView.rightLabel.text = array[itemIndex];
        [cellView layoutSubviews];
        
    };
    [dialogViewController show];
}





#pragma mark 网络

// 临时
-(void)postPrescriptionTemp
{
    if (self.frequencyView.rightLabel.text == nil || self.useView.rightLabel.text == nil ) {
        [MBProgressHUD showError:@"请填写完整信息" ToView:nil];
        return;
    }
    
    
    AddRecipeTempletChild_TempService *request = [[AddRecipeTempletChild_TempService alloc] initWithDocid:DoctorUserDefault.ID medcid:[NSString stringWithFormat:@"%ld",self.model.ID] yongliang:_amountCount.text pinci:self.frequencyView.rightLabel.text days:self.daysView.rightLabel.text num:self.countView.rightLabel.text yongfa:self.useView.rightLabel.text zhutuo:_entrustTextView.text];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"保存药品 %@",request.responseString);
        
        for (PrescriptionTemplateViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass: [PrescriptionTemplateViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"添加失败" ToView:nil];
        NSLog(@"保存药品 %@",request.error);
    }];
    
}


// 临时
-(void)updatePrescriptionTemp
{
    UpdateRecipeTempletChild_TempService *request = [[UpdateRecipeTempletChild_TempService alloc] initWithDocid:DoctorUserDefault.ID detailid:[NSString stringWithFormat:@"%ld",self.model.ID] medcid:[NSString stringWithFormat:@"%ld",self.model.medcid] yongliang:_amountCount.text pinci:self.frequencyView.rightLabel.text days:self.daysView.rightLabel.text num:self.countView.rightLabel.text yongfa:self.useView.rightLabel.text zhutuo:_entrustTextView.text];
    
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"更新药品 %@",request.responseString);
        
        for (PrescriptionTemplateViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass: [PrescriptionTemplateViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"添加失败" ToView:nil];
        NSLog(@"更新药品 %@",request.error);
    }];
    
    
}



// 正式模板
-(void)postPrescription
{
    if (self.frequencyView.rightLabel.text == nil || self.useView.rightLabel.text == nil ) {
        [MBProgressHUD showError:@"请填写完整信息" ToView:nil];
        return;
    }
    
    
    AddRecipeTempletChildService *request = [[AddRecipeTempletChildService alloc] initWithTempletid:self.templetId medcid:[NSString stringWithFormat:@"%ld",self.model.ID] yongliang:_amountCount.text pinci:self.frequencyView.rightLabel.text days:self.daysView.rightLabel.text num:self.countView.rightLabel.text yongfa:self.useView.rightLabel.text zhutuo:_entrustTextView.text];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"保存正式药品 %@",request.responseString);
        
        for (PrescriptionTemplateViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass: [PrescriptionTemplateViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"添加失败" ToView:nil];
        NSLog(@"保存正式药品 %@",request.error);
    }];
    
}




-(void)updatePrescription
{
    UpdateRecipeTempletChildService *request = [[UpdateRecipeTempletChildService alloc] initWithDocid:DoctorUserDefault.ID detailid:[NSString stringWithFormat:@"%ld",self.model.ID] medcid:[NSString stringWithFormat:@"%ld",self.model.medcid] yongliang:_amountCount.text pinci:self.frequencyView.rightLabel.text days:self.daysView.rightLabel.text num:self.countView.rightLabel.text yongfa:self.useView.rightLabel.text zhutuo:_entrustTextView.text];
    
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"更新正式药品 %@",request.responseString);
        
        for (PrescriptionTemplateViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass: [PrescriptionTemplateViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:@"添加失败" ToView:nil];
        NSLog(@"更新正式药品 %@",request.error);
    }];
    
    
}




#pragma mark 懒加载


-(WRCellView *)nameView
{
    if (!_nameView) {
        
        _nameView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _nameView.leftLabel.text = @"药品名称";
        _nameView.rightLabel.text = self.model.medcname;
        _nameView.rightLabel.textColor = darkShenColor;
        [_nameView setLineStyleWithLeftZero];
    }
    
    return _nameView;
}

-(WRCellView *)specificationsView
{
    if (!_specificationsView) {
        
        _specificationsView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _specificationsView.leftLabel.text = @"药品规格";
        _specificationsView.rightLabel.text = self.model.spec;
        _specificationsView.rightLabel.textColor = darkShenColor;
        [_specificationsView setLineStyleWithLeftZero];
    }
    
    return _specificationsView;
}

-(WRCellView *)frequencyView
{
    if (!_frequencyView) {
        
        _frequencyView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _frequencyView.leftLabel.text = @"频次";
        _frequencyView.rightLabel.text = self.model.pinci;
        _frequencyView.rightLabel.textColor = darkShenColor;
        [_frequencyView setLineStyleWithLeftZero];
    }
    
    return _frequencyView;
}

-(WRCellView *)daysView
{
    if (!_daysView) {
        
        _daysView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _daysView.leftLabel.text = @"天数";
        _daysView.rightLabel.text = [NSString stringWithFormat:@"%ld",self.model.days];;
        _daysView.rightLabel.textColor = darkShenColor;
        [_daysView setLineStyleWithLeftZero];
    }
    
    return _daysView;
}


-(WRCellView *)countView
{
    if (!_countView) {
        
        _countView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _countView.leftLabel.text = @"数量";
        _countView.rightLabel.text = [NSString stringWithFormat:@"%ld",self.model.num];
        _countView.rightLabel.textColor = darkShenColor;
        [_countView setLineStyleWithLeftZero];
    }
    
    return _countView;
}


-(WRCellView *)useView
{
    if (!_useView) {
        
        _useView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _useView.leftLabel.text = @"用法";
        _useView.rightLabel.text = self.model.yongfa;
        _useView.rightLabel.textColor = darkShenColor;
        [_useView setLineStyleWithLeftZero];
    }
    
    return _useView;
}

@end
