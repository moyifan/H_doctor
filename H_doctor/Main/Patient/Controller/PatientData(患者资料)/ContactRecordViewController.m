//
//  ContactRecordViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/8.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ContactRecordViewController.h"
#import "SGPageView.h"
#import "RecordChatViewController.h"
#import "RecordVideoViewController.h"

@interface ContactRecordViewController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation ContactRecordViewController

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
    
    
    [self setupSubViews];
    
}





-(void)setupSubViews
{
    
    RecordChatViewController *chat = [[RecordChatViewController alloc] init];
    chat.userId = self.userId;
    RecordVideoViewController *video = [[RecordVideoViewController alloc] init];
    video.userId = self.userId;
    
    NSArray *childArr = @[chat,video];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height-64-44;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0,64+44, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [_pageContentView setIsScrollEnabled:NO];
    [self.view addSubview:_pageContentView];
    
    
    
    NSArray *titleArr = @[@"图文接诊",@"视频接诊"];
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
}

// 滚动内容视图
- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}







@end
