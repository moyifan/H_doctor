//
//  SelevtHospitalViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/18.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "SelevtHospitalViewController.h"
#import "SelectCityViewController.h"
#import "SGPageView.h"
#import "HospitalViewController.h"
#import "SearchHospitalService.h"
#import "AllCityModel.h"

@interface SelevtHospitalViewController ()<UITextFieldDelegate,SGPageContentViewDelegate>
@property (nonatomic,strong) UITextField *search;

@property (nonatomic, strong) SGPageContentView *pageContentView;

@property (nonatomic, strong) HospitalViewController *hos;

//@property (nonatomic, strong) Hosptllist *hosModel;

@end

@implementation SelevtHospitalViewController

-(void)setNavBar
{
    
    [self.navigationView addTitleView:self.search];
    
    self.search.sd_layout.bottomSpaceToView(self.navigationView, 10).widthIs(322).heightIs(28);
    
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(242, 246, 250);


    [self setNavBar];

    [self setupSubViews];
}



-(void)setupSubViews
{
    SelectCityViewController *selectCity = [[SelectCityViewController alloc] init];
    selectCity.cityState = city;

    
    
    HospitalViewController *hospital = [[HospitalViewController alloc] init];
    self.hos = hospital;
    hospital.hospitalState = hos;
    
    
    
    MPWeakSelf(self)
    selectCity.ReturnHosValueBlock = ^(NSArray<Hosptllist *> *hosList){
        
        [weakself.pageContentView setPageCententViewCurrentIndex:1];
        
        hospital.hosModel = hosList;
        
    };
    
    
    hospital.ReturnHosValueBlock = ^(NSString *strValue, NSString *ID){
        if (weakself.ReturnValueBlock) {
            weakself.ReturnValueBlock(strValue,ID);
        }
    };
    
    
    
    NSArray *childArr = @[selectCity,hospital];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height-64;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [_pageContentView setIsScrollEnabled:NO];
    [self.view addSubview:_pageContentView];
 
    
}



#pragma mark uitextfild 代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self searchByText:textField.text];
    
    return YES;
}



#pragma mark 网络

-(void)searchByText:(NSString *)text
{
    [MBProgressHUD showLoadToView:nil];
    
    SearchHospitalService *request = [[SearchHospitalService alloc] initWithKeyword:text];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"全部医院 %@",request.responseString);
        
        if ([request.responseJSONObject[@"ds"] isEqual:@[]]) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"无搜索结果" ToView:nil];
            return;
        }
        
        
        [MBProgressHUD hideHUD];
        Citylist *hosModel = [Citylist yy_modelWithJSON:request.responseJSONObject];
      
        self.hos.hosModel = hosModel.hosptllist;
        
        [self.pageContentView setPageCententViewCurrentIndex:1];
            
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@" %@",request.error);
    }];
    
    [self.pageContentView setPageCententViewCurrentIndex:1];

}


#pragma mark 懒加载

-(UITextField *)search
{
    if (!_search) {
        
        _search = [[UITextField alloc] init];
        [_search setBackground:[UIImage imageNamed:@"circular_c"]];
        
        UIImageView *left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fangdajing_icon"]];
        
        _search.leftView = left;
        _search.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _search.placeholder = @"请输入医院名称的关键字";
        _search.textColor = darkShenColor;
        _search.font = PingFangFONT(14);
        _search.delegate = self;
        _search.returnKeyType = UIReturnKeySearch;
        [_search sizeToFit];
        
    }
    
    return _search;
}






@end
