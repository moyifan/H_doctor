//
//  RecordLineViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "RecordLineViewController.h"
#import "SGPageView.h"
#import "RecordChatViewController.h"
#import "RecordVideoViewController.h"

@interface RecordLineViewController ()<UITextFieldDelegate,SGPageContentViewDelegate>
@property (nonatomic,strong) UITextField *search;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation RecordLineViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"接诊记录"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setNavBar];
    
    [self setupSearch];

    [self setupSubViews];
    
}


-(void)setupSearch
{
    [self.view addSubview:self.search];
    
    self.search.sd_layout.leftSpaceToView(self.view, 15).rightSpaceToView(self.view, 15).topSpaceToView(self.view, 8+64).heightIs(28);
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    [self.view addSubview:line];
    
    line.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.search, 9).heightIs(1);
    
}



-(void)setupSubViews
{
    [self.search updateLayout];
    
    RecordChatViewController *chat = [[RecordChatViewController alloc] init];
    
    NSArray *childArr = @[chat];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height-CGRectGetMaxY(self.search.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.search.frame), self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [_pageContentView setIsScrollEnabled:NO];
    [self.view addSubview:_pageContentView];
    
    
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
        _search.placeholder = @"请输入患者姓名、电话";
        _search.textColor = darkShenColor;
        _search.font = PingFangFONT(14);
        _search.delegate = self;
        _search.returnKeyType = UIReturnKeySearch;
        
    }
    
    return _search;
}


@end
