//
//  HomeViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/6.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "MyPharmacyViewController.h"
#import "ContactAllRecordViewController.h"
#import "ChatListViewController.h"
#import "MyFeesViewController.h"
#import "TemplateSettingViewController.h"
#import "ReceptionSettingViewController.h"
#import "ChatVideoListViewController.h"

#import "PrescribePrescriptionViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *showView;
@property (nonatomic,strong) UICollectionView *collect;
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation HomeViewController
{
    UILabel *_receivePeople;
    UILabel *_prescription;
    UILabel *_receiveTime;
    
}

-(void)setNavBar
{

    [self.navigationView setNavigationBackgroundAlpha:0];
    
    [self.navigationView setTitle:@"科医大医生"];
    
    
    MPWeakSelf(self)
    [self.navigationView addLeftButtonWithTitle:@"统计" clickCallBack:^(UIView *view) {
        
    }];
   
    
    [self.navigationView addRightButtonWithImage:[UIImage imageNamed:@"news_icon"] hightImage:nil clickCallBack:^(UIView *view) {
        PrescribePrescriptionViewController *pre = [[PrescribePrescriptionViewController alloc] init];
        [weakself.navigationController pushViewController:pre animated:YES];
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(242, 246, 250);
    
    [self setNavBar];
    
    
    // 展示View
    
    _showView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingbubg_icon"]];
    
    [self.view addSubview:_showView];
    _showView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(202);
    
    
    [self setupSubViews];
    
    [self setUpCollection];
    
    [self setUpTableView];
    
}


-(void)setupSubViews
{
    // 累计接诊
    
    _receivePeople = [[UILabel alloc] init];
    _receivePeople.textColor = [UIColor whiteColor];
    _receivePeople.font = [UIFont fontWithName:@"Helvetica-Bold" size:35.0f];
    _receivePeople.text = @"20";
    
    _prescription = [[UILabel alloc] init];
    _prescription.textColor = [UIColor whiteColor];
    _prescription.font = [UIFont fontWithName:@"Helvetica-Bold" size:35.0f];
    _prescription.text = @"16";
    
    _receiveTime = [[UILabel alloc] init];
    _receiveTime.textColor = [UIColor whiteColor];
    _receiveTime.font = [UIFont fontWithName:@"Helvetica-Bold" size:35.0f];
    _receiveTime.text = @"21";
    
    [_showView addSubview:_receivePeople];
    [_showView addSubview:_prescription];
    [_showView addSubview:_receiveTime];
    
    
    _receivePeople.sd_layout.leftSpaceToView(_showView, 32).topSpaceToView(_showView, 99).heightIs(_receivePeople.font.lineHeight);
    [_receivePeople setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _prescription.sd_layout.centerXEqualToView(_showView).topSpaceToView(_showView, 99).heightIs(_prescription.font.lineHeight);
    [_prescription setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _receiveTime.sd_layout.rightSpaceToView(_showView, 56).topSpaceToView(_showView, 99).heightIs(_receiveTime.font.lineHeight);
    [_receiveTime setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    
    // label
    
    UILabel *receivePeopleLabel = [[UILabel alloc] init];
    receivePeopleLabel.textColor = [UIColor whiteColor];
    receivePeopleLabel.font = PingFangFONT(12);
    receivePeopleLabel.text = @"累计接诊用户";
    
    
    UILabel *prescriptionLabel = [[UILabel alloc] init];
    prescriptionLabel.textColor = [UIColor whiteColor];
    prescriptionLabel.font = PingFangFONT(12);
    prescriptionLabel.text = @"累计处方量";
    
    
    UILabel *receiveTimeLabel = [[UILabel alloc] init];
    receiveTimeLabel.textColor = [UIColor whiteColor];
    receiveTimeLabel.font = PingFangFONT(12);
    receiveTimeLabel.text = @"累计接诊时间(小时)";
    
    
    [_showView addSubview:receivePeopleLabel];
    [_showView addSubview:prescriptionLabel];
    [_showView addSubview:receiveTimeLabel];
    
    receivePeopleLabel.sd_layout.centerXEqualToView(_receivePeople).topSpaceToView(_receivePeople, 10).heightIs(receivePeopleLabel.font.lineHeight);
    [receivePeopleLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    prescriptionLabel.sd_layout.centerXEqualToView(_prescription).topSpaceToView(_prescription, 10).heightIs(prescriptionLabel.font.lineHeight);
    [prescriptionLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    receiveTimeLabel.sd_layout.centerXEqualToView(_receiveTime).topSpaceToView(_receiveTime, 10).heightIs(receiveTimeLabel.font.lineHeight);
    [receiveTimeLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
}


#define HomeCollectionCell @"HomeCollectionViewCell"

#pragma mark collection
-(void)setUpCollection
{
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为横向布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake((Main_Screen_Width-1)/2, (188-1)/2);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 202, Main_Screen_Width, 188) collectionViewLayout:layout];
    _collect = collect;
    collect.backgroundColor = RGB(242, 246, 250);
    collect.showsHorizontalScrollIndicator = NO;
    
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    //注册item类型 这里使用系统的类型
    [collect registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:HomeCollectionCell];
    
    [self.view addSubview:collect];
}

#pragma mark collection datasoure
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCollectionCell forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (DoctorUserDefault.isLogin) {
        
        if (indexPath.row == 0) {
            ChatVideoListViewController *video = [[ChatVideoListViewController alloc] init];
            [self.navigationController pushViewController:video animated:YES];
        }else if (indexPath.row == 1){
            ChatListViewController *list = [[ChatListViewController alloc] init];
            [self.navigationController pushViewController:list animated:YES];
            //        [MBProgressHUD showAutoMessage:@"该功能暂未开放"];
        }else if (indexPath.row == 2){
            MyPharmacyViewController *myPhaarmacy = [[MyPharmacyViewController alloc] init];
            [self.navigationController pushViewController:myPhaarmacy animated:YES];
        }else{
            MyFeesViewController *fees = [[MyFeesViewController alloc] init];
            [self.navigationController pushViewController:fees animated:YES];
        }
        
    }else{
        [((AppDelegate *)AppDelegateInstance) setupLoginViewController];
        
    }
   
    
}


#pragma mark TableView

-(void)setUpTableView
{

    // table
    
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.scrollEnabled = NO;
    
    [self.view addSubview:tableview];
    
//    [self.tableview.tableHeaderView addSubview:common];

    
    tableview.sd_layout.leftEqualToView(self.view).topSpaceToView(self.collect, 11).rightEqualToView(self.view).bottomSpaceToView(self.view, 0);
    
    
}


#pragma mark tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIButton *common = [[UIButton alloc] init];
    [common setBackgroundColor:[UIColor whiteColor]];
    [common setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
    [common setTitle:@"常用功能" forState:UIControlStateNormal];
    [common setTitleColor:darkShenColor forState:UIControlStateNormal];
    common.titleLabel.font = PingFangFONT(14);
    [common lc_imageTitleHorizontalAlignmentWithSpace:5];
    common.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    common.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
    
    return common;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 13;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *foot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_foot"]];
    [foot sizeToFit];
    
    return foot;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"HomeTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    cell.textLabel.font = PingFangFONT(16);
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"shouye_jiezhenjilu_icon"];
        cell.textLabel.text = @"接诊记录";
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = RGB(239, 239, 239);
        [cell.contentView addSubview:line];
        line.sd_layout.leftEqualToView(cell.contentView).rightEqualToView(cell.contentView).bottomEqualToView(cell.contentView).heightIs(1);
        
    }else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"shouye_chufangmuban_icon"];
        cell.textLabel.text = @"处方模板";
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = RGB(239, 239, 239);
        [cell.contentView addSubview:line];
        line.sd_layout.leftEqualToView(cell.contentView).rightEqualToView(cell.contentView).bottomEqualToView(cell.contentView).heightIs(1);
        
    }else{
        cell.imageView.image = [UIImage imageNamed:@"shouye_jiezhenshezhi_icon"];
        cell.textLabel.text = @"接诊设置";
    }
    
    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gengduo_icon"]];
    [cell.contentView addSubview:back];
    [back sizeToFit];
    back.sd_layout.rightSpaceToView(cell.contentView,18).centerYEqualToView(cell.contentView).widthIs(back.width).heightIs(back.height);
    
  
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (tableView.height-45-13)/3;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (DoctorUserDefault.isLogin) {
        
        if (indexPath.row == 0) {
            ContactAllRecordViewController *record = [[ContactAllRecordViewController alloc] init];
            [self.navigationController pushViewController:record animated:YES];
        }else if (indexPath.row == 1){
            TemplateSettingViewController *setting = [[TemplateSettingViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
        }else{
            ReceptionSettingViewController *reception = [[ReceptionSettingViewController alloc] init];
            [self.navigationController pushViewController:reception animated:YES];
        }
        
    }else{
        [((AppDelegate *)AppDelegateInstance) setupLoginViewController];
        
    }
    

}









@end
