//
//  DiagnosisViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "DiagnosisViewController.h"

#import "GetSicknessByKeywordService.h"
#import "SicknessModel.h"

@interface DiagnosisViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITextField *search;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UIScrollView *backView;
@property (nonatomic, strong) QMUITextView *customTextView;
@property (nonatomic, strong) UIView *resultView;  //诊断输出
@property (nonatomic, strong) UIView *resultBtnView;  //诊断输出btnView
@property (nonatomic, strong) NSMutableArray *diagnosisArray;
@property (nonatomic, strong) NSMutableArray *diagnosisIDArray;

//@property(nonatomic, strong) QMUIFloatLayoutView *ICUBtnView;
//@property(nonatomic, strong) QMUIFloatLayoutView *keshiBtnView;
@property(nonatomic, strong) SicknessModel *model;


@end

@implementation DiagnosisViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"诊断"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"完成" clickCallBack:^(UIView *view) {
     
        [weakself SaveSickness];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AllBG;
    
    [self setNavBar];
    
    [self setupTableView];

    [self setupSearch];
    
    [self setupSubViews];
    
 
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



-(void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] init];
    self.tableView = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:tableview];
    
    tableview.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).topSpaceToView(self.searchView, 0);
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.ds.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *illIdentifier = @"SearchResultTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:illIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:illIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = PingFangFONT(16);
    cell.textLabel.textColor = darkShenColor;
    cell.textLabel.text = self.model.ds[indexPath.row].sicknessname;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.state == Chufang) {
        
        [self.diagnosisArray addObject:self.model.ds[indexPath.row].sicknessname];
        [self.diagnosisIDArray addObject:[NSString stringWithFormat:@"%ld",self.model.ds[indexPath.row].ID]];
    }else{
        if (self.diagnosisArray.count == 0) {
            [self.diagnosisArray addObject:self.model.ds[indexPath.row].sicknessname];
            [self.diagnosisIDArray addObject:[NSString stringWithFormat:@"%ld",self.model.ds[indexPath.row].ID]];
        }else{
            [self.diagnosisArray replaceObjectAtIndex:0 withObject:self.model.ds[indexPath.row].sicknessname];
            [self.diagnosisIDArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",self.model.ds[indexPath.row].ID]];


        }
    }
    
    [self layoutBtns];

    [self.view bringSubviewToFront:self.backView];

}


//其他View
-(void)setupSubViews
{
    UIScrollView *backView = [[UIScrollView alloc] init];
    self.backView = backView;
    backView.backgroundColor = AllBG;
    backView.showsVerticalScrollIndicator = NO;
    backView.delegate = self;
    
    // 自定义诊断
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor whiteColor];
    
    UIButton *common = [[UIButton alloc] init];
    [common setBackgroundColor:[UIColor whiteColor]];
    [common setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
    [common setTitle:@"自定义诊断" forState:UIControlStateNormal];
    [common setTitleColor:darkzhongColor forState:UIControlStateNormal];
    common.titleLabel.font = AdaptedFontSize(14);
    [common lc_imageTitleHorizontalAlignmentWithSpace:5];
    common.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    common.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
    
    _customTextView = [[QMUITextView alloc] init];
    _customTextView.placeholder = @"请输入文字对诊断进行补充...";
    _customTextView.placeholderColor = darkQianColor;
    _customTextView.font = PingFangFONT(16);
    
    
    //诊断输出
    UIView *resultView = [[UIView alloc] init];
    resultView.backgroundColor = [UIColor whiteColor];
    self.resultView = resultView;
    
    UIButton *resultBtn = [[UIButton alloc] init];
    [resultBtn setBackgroundColor:[UIColor whiteColor]];
    [resultBtn setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
    [resultBtn setTitle:@"诊断输出" forState:UIControlStateNormal];
    [resultBtn setTitleColor:darkzhongColor forState:UIControlStateNormal];
    resultBtn.titleLabel.font = AdaptedFontSize(14);
    [resultBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
    resultBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    resultBtn.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
    
    self.resultBtnView = [[UIView alloc] init];
    self.resultBtnView.backgroundColor = [UIColor whiteColor];
    
    
    //常用ICD
//    UIView *ICUView = [[UIView alloc] init];
//    ICUView.backgroundColor = [UIColor whiteColor];
//
//    UIButton *ICUBtn = [[UIButton alloc] init];
//    [ICUBtn setBackgroundColor:[UIColor whiteColor]];
//    [ICUBtn setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
//    [ICUBtn setTitle:@"常用ICU诊断" forState:UIControlStateNormal];
//    [ICUBtn setTitleColor:darkzhongColor forState:UIControlStateNormal];
//    ICUBtn.titleLabel.font = AdaptedFontSize(14);
//    [ICUBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
//    ICUBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    ICUBtn.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
    
//    self.ICUBtnView = [[QMUIFloatLayoutView alloc] init];
//    self.ICUBtnView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
//    self.ICUBtnView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
//    self.ICUBtnView.minimumItemSize = CGSizeMake(69, 29);// 以2个字的按钮作为最小宽度
  
   
//    NSArray<NSString *> *suggestions = @[@"东野圭吾", @"三体", @"爱", @"红楼梦", @"理智与情感", @"读书热榜", @"免费榜"];
//    for (NSInteger i = 0; i < suggestions.count; i++) {
//        QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
//        button.ghostColor = darkQianColor;
//        [button setTitle:suggestions[i] forState:UIControlStateNormal];
//        button.titleLabel.font = PingFangFONT(15);
//        button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
//        button.tag = 1200+i;
//        [button addTarget:self action:@selector(didClickICUBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self.ICUBtnView addSubview:button];
//    }
    
    
    //科室常用诊断
//    UIView *keshiView = [[UIView alloc] init];
//    keshiView.backgroundColor = [UIColor whiteColor];
//
//    UIButton *keshiBtn = [[UIButton alloc] init];
//    [keshiBtn setBackgroundColor:[UIColor whiteColor]];
//    [keshiBtn setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
//    [keshiBtn setTitle:@"科室常用诊断" forState:UIControlStateNormal];
//    [keshiBtn setTitleColor:darkzhongColor forState:UIControlStateNormal];
//    keshiBtn.titleLabel.font = AdaptedFontSize(14);
//    [keshiBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
//    keshiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    keshiBtn.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
    
//    self.keshiBtnView = [[QMUIFloatLayoutView alloc] init];
//    self.keshiBtnView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
//    self.keshiBtnView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
//    self.keshiBtnView.minimumItemSize = CGSizeMake(69, 29);// 以2个字的按钮作为最小宽度
    
    
//    NSArray<NSString *> *keshi = @[@"东野圭吾", @"三体", @"爱", @"红楼梦", @"理智与情感", @"读书热榜", @"免费榜"];
//    for (NSInteger i = 0; i < keshi.count; i++) {
//        QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
//        button.ghostColor = darkQianColor;
//        [button setTitle:keshi[i] forState:UIControlStateNormal];
//        button.titleLabel.font = PingFangFONT(15);
//        button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
//        button.tag = 1400+i;
//        [button addTarget:self action:@selector(didClickKeshiBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self.keshiBtnView addSubview:button];
//    }
    
    
    
    
    // layout
    [self.view addSubview:backView];
    
    [backView addSubview:customView];
    [customView addSubview:common];
    [customView addSubview:_customTextView];
    
    [backView addSubview:resultView];
    [resultView addSubview:resultBtn];
    [resultView addSubview:self.resultBtnView];
    
//    [backView addSubview:ICUView];
//    [ICUView addSubview:ICUBtn];
//    [ICUView addSubview:self.ICUBtnView];
//
//    [backView addSubview:keshiView];
//    [keshiView addSubview:keshiBtn];
//    [keshiView addSubview:self.keshiBtnView];

  backView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.searchView, 0).bottomEqualToView(self.view);
    
    // 诊断
    customView.sd_layout.leftEqualToView(backView).rightEqualToView(backView).topEqualToView(backView).heightIs(140);
    common.sd_layout.leftEqualToView(customView).topEqualToView(customView).rightEqualToView(customView).heightIs(44);
    
    _customTextView.sd_layout.leftSpaceToView(customView, 16).rightSpaceToView(customView, 16).topSpaceToView(common, 0).bottomEqualToView(customView);
   
    // 诊断输出
    resultView.sd_layout.leftEqualToView(backView).rightEqualToView(backView).topSpaceToView(customView, 10);
    resultBtn.sd_layout.leftEqualToView(resultView).topEqualToView(resultView).rightEqualToView(resultView).heightIs(44);
    
        self.resultBtnView.sd_layout.leftSpaceToView(resultView, 16).rightSpaceToView(resultView, 16).topSpaceToView(resultBtn,0);
    
    [self.resultView setupAutoHeightWithBottomView:self.resultBtnView bottomMargin:5];

    // ICU
//    ICUView.sd_layout.leftEqualToView(backView).rightEqualToView(backView).topSpaceToView(resultView, 10);
//    ICUBtn.sd_layout.leftEqualToView(ICUView).topEqualToView(ICUView).rightEqualToView(ICUView).heightIs(44);
//
//    CGSize floatLayoutViewSize = [self.ICUBtnView sizeThatFits:CGSizeMake(self.view.width-30, CGFLOAT_MAX)];
//    self.ICUBtnView.sd_layout.leftSpaceToView(ICUView, 15).rightSpaceToView(ICUView, 15).topSpaceToView(ICUBtn, 0).heightIs(floatLayoutViewSize.height);
//
//    [ICUView setupAutoHeightWithBottomView:self.ICUBtnView bottomMargin:0];
    
    //科室
    
//    keshiView.sd_layout.leftEqualToView(backView).rightEqualToView(backView).topSpaceToView(ICUView, 10);
//    keshiBtn.sd_layout.leftEqualToView(keshiView).topEqualToView(keshiView).rightEqualToView(keshiView).heightIs(44);
//
//    CGSize keshiSize = [self.keshiBtnView sizeThatFits:CGSizeMake(self.view.width-30, CGFLOAT_MAX)];
//    self.keshiBtnView.sd_layout.leftSpaceToView(keshiView, 15).rightSpaceToView(keshiView, 15).topSpaceToView(ICUBtn, 0).heightIs(keshiSize.height);
//
//    [keshiView setupAutoHeightWithBottomView:self.keshiBtnView bottomMargin:0];
//
//
//    [backView setupAutoContentSizeWithBottomView:keshiView bottomMargin:0];
}


-(void)layoutBtns
{
    [self.resultBtnView qmui_removeAllSubviews];
    
    MPWeakSelf(self)
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    [self.diagnosisArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        QMUIButton *result = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"search_delete"] title:obj];
        [result setTitleColor:darkShenColor forState:UIControlStateNormal];
        result.titleLabel.font = PingFangFONT(16);
        result.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        result.imagePosition = QMUIButtonImagePositionRight;
        result.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [result sizeToFit];
        result.tag = 1314+idx;
        [result addTarget:self action:@selector(didClickResultBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [weakself.resultBtnView addSubview:result];
        result.sd_layout.heightIs(result.height);// 设置高度约束
        
        [temp addObject:result];
    }];
    
    
    [self.resultBtnView setupAutoWidthFlowItems:temp withPerRowItemsCount:1 verticalMargin:5 horizontalMargin:0 verticalEdgeInset:2 horizontalEdgeInset:0];
    
    [self.resultView setupAutoHeightWithBottomView:self.resultBtnView bottomMargin:0];
    
    
    
}


//
-(void)didClickResultBtn:(UIButton *)sender
{
    [self.diagnosisArray removeObjectAtIndex:sender.tag-1314];
    
    [self layoutBtns];
}




// ICU
//-(void)didClickICUBtn:(QMUIGhostButton *)sender
//{
//    if ([sender.ghostColor isEqual:darkQianColor]) {
//
//        sender.ghostColor = RGB(72,147,245);
//    }else{
//        sender.ghostColor = darkQianColor;
//    }
//
//}

// 科室
//-(void)didClickKeshiBtn:(QMUIGhostButton *)sender
//{
//    if ([sender.ghostColor isEqual:darkQianColor]) {
//
//        sender.ghostColor = RGB(72,147,245);
//    }else{
//        sender.ghostColor = darkQianColor;
//    }
//
//}

#pragma mark textfildDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view sendSubviewToBack:self.backView];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.view bringSubviewToFront:self.backView];
    
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self GetSicknessByKeyword:textField.text];
    
    return YES;
}






#pragma mark 网络

-(void)GetSicknessByKeyword:(NSString *)keyword
{
    GetSicknessByKeywordService *request = [[GetSicknessByKeywordService alloc] initWithPagesize:@"100" page:@"1" keyword:keyword];
    
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"诊断列表药品 %@",request.responseString);
        
        self.model = [SicknessModel yy_modelWithJSON:request.responseJSONObject];

        [self.tableView reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"诊断列表药品 %@",request.error);
    }];

}



-(void)SaveSickness
{
    if (self.ReturnValueBlock) {
        self.ReturnValueBlock(self.diagnosisArray, self.diagnosisIDArray,self.customTextView.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
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


-(NSMutableArray *)diagnosisArray
{
    if (!_diagnosisArray) {
        _diagnosisArray = [NSMutableArray array];
    }
    return _diagnosisArray;
}

-(NSMutableArray *)diagnosisIDArray
{
    if (!_diagnosisIDArray) {
        _diagnosisIDArray = [NSMutableArray array];
    }
    return _diagnosisIDArray;
}


@end
