//
//  MyFeesViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "MyFeesViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MyFeesTableViewCell.h"
#import "SGPageView.h"

@interface MyFeesViewController ()<QMUITableViewDelegate,QMUITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,SGPageTitleViewDelegate>
@property (nonatomic,strong) QMUILabel *priceLabel;
@property (nonatomic,strong) QMUITableView *tableview;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;

@property (nonatomic, strong) UIView *tipView;

@end

@implementation MyFeesViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"我的诊费"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"诊费说明" clickCallBack:^(UIView *view) {
        
        QMUIModalPresentationViewController *alert = [[QMUIModalPresentationViewController alloc] init];
        alert.contentView = weakself.tipView;
        
        [alert showWithAnimated:YES completion:^(BOOL finished) {
            
        }];
      
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AllBG;
    
    [self setNavBar];
    
    [self setupSubViews];
        
    [self setupTableView];
    
    
    
    // 有数据时显示reloaddata，无数据时刷新emptydata
    [self.tableview reloadEmptyDataSet];
    

}


-(void)setupSubViews
{
    NSString *priceText = @"诊费收入： 10000.00 元";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:priceText];
    
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(16) range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(16) range:NSMakeRange(priceText.length-1, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:darkShenColor range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:darkShenColor range:NSMakeRange(priceText.length-1, 1)];
    
    //8888-80 text-style1
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(25) range:NSMakeRange(6, priceText.length-7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGB(72,147,245) range:NSMakeRange(6, priceText.length-7)];
    
    
    QMUILabel *price = [[QMUILabel alloc] init];
    self.priceLabel = price;
    price.attributedText = attributedString;
    price.backgroundColor = [UIColor whiteColor];
    price.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);

    [self.view addSubview:price];
    
    price.sd_layout.topSpaceToView(self.view, 10+64).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(50);
    price.isAttributedContent = YES;
    
    
    [price updateLayout];
    
    //
    NSArray *titleArr = @[@"图文接诊",@"视频接诊"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, CGRectGetMaxY(price.frame)+10, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.titleColorStateNormal = darkQianColor;
    _pageTitleView.titleColorStateSelected = RGB(72, 147, 245);
    _pageTitleView.indicatorColor = RGB(72, 147, 245);
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    
}


// 滚动标题视图
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {


}



#define Identifier @"MyFeesTableViewCell"

-(void)setupTableView
{
    QMUITableView *tableview = [[QMUITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[MyFeesTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
    
    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.pageTitleView, 0).rightEqualToView(self.view).bottomSpaceToView(self.view, 0);
    
    
    tableview.emptyDataSetSource = self;
    tableview.emptyDataSetDelegate = self;
    
    
}



#pragma mark NoData data source
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"pig_icon_pic"];
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"当前没有诊费收入记录哦！";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:PingFangFONT(16),
                                 NSForegroundColorAttributeName:darkQianColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}



- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    UIColor *appleGreenColor = AllBG;
    return appleGreenColor;
}


- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}



#pragma mark tableviewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyFeesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell高度
    
    return 44;
    
}






// 点击取消蒙版
-(void)didClickcancle
{
    [QMUIModalPresentationViewController hideAllVisibleModalPresentationViewControllerIfCan];
}




#pragma mark 懒加载

-(UIView *)tipView
{
    if (!_tipView) {
        
        _tipView = [[UIView alloc] init];
        _tipView.backgroundColor = [UIColor clearColor];
        
        UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shuoming_icon"]];
        [customView sizeToFit];
        
        QMUIButton *cancel = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"delete_big_icon"] title:nil];
        [cancel sizeToFit];
        [cancel addTarget:self action:@selector(didClickcancle) forControlEvents:UIControlEventTouchUpInside];
        
        [_tipView addSubview:customView];
        [_tipView addSubview:cancel];
        
        _tipView.sd_layout.widthIs(customView.width);
        
        customView.sd_layout.leftEqualToView(_tipView).topEqualToView(_tipView).rightEqualToView(_tipView).heightIs(customView.height);
        cancel.sd_layout.centerXEqualToView(_tipView).bottomEqualToView(customView).offset(50+44).widthIs(cancel.width).heightIs(cancel.height);
        
        [_tipView setupAutoHeightWithBottomView:cancel bottomMargin:0];
        
    }
    
    return _tipView;
    
}



@end
