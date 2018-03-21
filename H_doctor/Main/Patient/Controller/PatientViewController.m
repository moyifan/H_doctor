//
//  PatientViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/6.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "PatientViewController.h"
#import "SGPageView.h"
#import "SigningPatientsViewController.h"
#import "MyPatientsViewController.h"

@interface PatientViewController ()<UITextFieldDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate>
@property (nonatomic,strong) UITextField *search;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@property (nonatomic, strong) SigningPatientsViewController *sign;
@property (nonatomic, strong) MyPatientsViewController *my;

@property (nonatomic, assign) NSInteger index;

@end

@implementation PatientViewController

-(void)setNavBar
{
    
    [self.navigationView addTitleView:self.search];
    
    
    self.search.sd_layout.bottomSpaceToView(self.navigationView, 10).leftSpaceToView(self.navigationView, 15).rightSpaceToView(self.navigationView, 15).heightIs(28);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(242, 246, 250);
    
    
    [self setNavBar];

    [self setupSubViews];

}



-(void)setupSubViews
{
    SigningPatientsViewController *sign = [[SigningPatientsViewController alloc] init];
    self.sign = sign;
    MyPatientsViewController *my = [[MyPatientsViewController alloc] init];
    self.my = my;
    
    NSArray *childArr = @[sign,my];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height-64-44;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0,64+44, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [_pageContentView setIsScrollEnabled:NO];
    [self.view addSubview:_pageContentView];
    
    
    
    NSArray *titleArr = @[@"签约患者",@"我的患者"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.titleColorStateNormal = darkQianColor;
    _pageTitleView.titleColorStateSelected = RGB(72, 147, 245);
    _pageTitleView.indicatorColor = RGB(72, 147, 245);
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    
}


// 滚动标题视图
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
    self.index = selectedIndex;
}

// 滚动内容视图
- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}






// 搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   
    if (self.index == 0) {
        [self.sign searchByKeyWord:textField.text];
    }else{
        [self.my searchByKeyWord:textField.text];
    }
    
    return YES;
}






-(UITextField *)search
{
    if (!_search) {
        
        _search = [[UITextField alloc] init];
        [_search setBackground:[UIImage imageNamed:@"circular_c"]];
        
        UIImageView *left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fangdajing_icon"]];
        
        _search.leftView = left;
        _search.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _search.placeholder = @"请输入姓名的关键字";
        _search.textColor = darkShenColor;
        _search.font = PingFangFONT(14);
        _search.delegate = self;
        _search.returnKeyType = UIReturnKeySearch;
        [_search sizeToFit];
        
    }
    
    return _search;
}
@end
