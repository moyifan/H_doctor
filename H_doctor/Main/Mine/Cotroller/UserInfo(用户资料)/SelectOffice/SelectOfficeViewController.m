//
//  SelectOfficeViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "SelectOfficeViewController.h"
#import "SelectCityViewController.h"
#import "SGPageView.h"


@interface SelectOfficeViewController ()<SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation SelectOfficeViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"选择科室"];

    
    MPWeakSelf(self)
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
    selectCity.cityState = office;
    
    MPWeakSelf(self)
    selectCity.ReturnValueBlock = ^(NSString *str , NSInteger ID){
        if (weakself.ReturnValueBlock) {
            weakself.ReturnValueBlock(str,ID);
        }
    };
    
    
    NSArray *childArr = @[selectCity];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height-64;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [_pageContentView setIsScrollEnabled:NO];
    [self.view addSubview:_pageContentView];
    
    
}



@end
