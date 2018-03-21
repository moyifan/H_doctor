//
//  ReceptionSettingViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ReceptionSettingViewController.h"
#import "ReceptionTableViewCell.h"
#import "TimeSelectViewController.h"

#import "GetDoctorPermitService.h"
#import "UpdatePermitService.h"
#import "GetDoctorTimeService.h"

@interface ReceptionSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *tipView;
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) NSDictionary *permitArray;
@property (nonatomic,strong) NSDictionary *timeArray;

@end

@implementation ReceptionSettingViewController



-(void)setNavBar
{
    [self.navigationView setTitle:@"接诊设置"];
    
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getDoctorTime];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AllBG;
    
    [self setNavBar];
   
    [self setupTableView];
    
    [self getDoctorPermit];
    
    [self getDoctorTime];
}


#define Identifier @"ReceptionTableViewCell"

-(void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableview = tableview;
    tableview.backgroundColor = AllBG;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerClass:[ReceptionTableViewCell class] forCellReuseIdentifier:Identifier];
    
    
    [self.view addSubview:tableview];
 
    tableview.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).topSpaceToView(self.view, 64);
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 34;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *tipStr;
    if (section == 0) {
        tipStr = @"处方药品权限";
    }else if(section == 1){
        tipStr = @"请选择支持的问诊形式";
    }else{
        tipStr = @"视频接诊时间设置";
    }
    
    UIButton *tip = [[UIButton alloc] init];
    [tip setTitle:tipStr forState:UIControlStateNormal];
    [tip setTitleColor:darkzhongColor forState:UIControlStateNormal];
    tip.titleLabel.font = PingFangFONT(13);
    tip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    tip.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    [tip sizeToFit];
    
    return tip;
}



#pragma mark tableviewData

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 7;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jingshen"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jingshen"];
        }
        
        cell.textLabel.text = @"精神类药品开具";
        
        [[cell.contentView viewWithTag:4444] removeFromSuperview];;
        
        UISwitch *swi = [[UISwitch alloc] init];
        swi.onTintColor = RGB(75, 139, 248);
        [swi addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        swi.tag = 4444;
        swi.on = [self.permitArray[@"spirit"] boolValue];
        [cell.contentView addSubview:swi];
        swi.sd_layout.centerYEqualToView(cell.contentView).rightSpaceToView(cell.contentView, 15);
        
        return cell;

        
    }else if (indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"state"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"state"];
        }
        
        
        if (indexPath.row == 0) {
            [[cell.contentView viewWithTag:5555] removeFromSuperview];;

            UISwitch *swi = [[UISwitch alloc] init];
            swi.onTintColor = RGB(75, 139, 248);
            [swi addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            
            [cell.contentView addSubview:swi];
            swi.sd_layout.centerYEqualToView(cell.contentView).rightSpaceToView(cell.contentView, 15);
            
            cell.imageView.image = [UIImage imageNamed:@"tuwenjiezhen_icon"];
            cell.textLabel.text = @"图文接诊";
            swi.tag = 5555;
            swi.on = [self.permitArray[@"imgtxt"] boolValue];
        }else{
            [[cell.contentView viewWithTag:6666] removeFromSuperview];;

            UISwitch *swi = [[UISwitch alloc] init];
            swi.onTintColor = RGB(75, 139, 248);
            [swi addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            
            [cell.contentView addSubview:swi];
            swi.sd_layout.centerYEqualToView(cell.contentView).rightSpaceToView(cell.contentView, 15);
            
            cell.imageView.image = [UIImage imageNamed:@"shipinjiezhen_icon"];
            cell.textLabel.text = @"视频接诊";
            swi.tag = 6666;
            swi.on = [self.permitArray[@"video"] boolValue];

        }

        
        return cell;

        
    }else{
        
        ReceptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        NSString *string = [formatter stringFromNumber:[NSNumber numberWithInteger:indexPath.row+1]];
        
        cell.fewWeeks.text = [NSString stringWithFormat:@"周%@",string];
        
        cell.dic = self.timeArray[@"ds"][indexPath.row];
        
        return cell;
        
    }
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TimeSelectViewController *time = [[TimeSelectViewController alloc] init];
    time.weekid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    time.titleName = @"选择排班时间";
    [self.navigationController pushViewController:time animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 80;

    }else{
        return 44;
    }
    
}




//
-(void)switchAction:(UISwitch *)sender
{

    switch (sender.tag) {
        case 4444:
            [self changePermitWith:sender.on who:@"UpdatePermit_Spirit"];
            break;
        case 5555:
            [self changePermitWith:sender.on who:@"UpdatePermit_Imgtxt"];
            break;
        case 6666:
            [self changePermitWith:sender.on who:@"UpdatePermit_Video"];
            break;

        default:
            break;
    }
    
}


                                                                                                                          

// 点击取消蒙版
-(void)didClickcancle
{
    [QMUIModalPresentationViewController hideAllVisibleModalPresentationViewControllerIfCan];
}





#pragma mark 网络
-(void)getDoctorPermit
{
    GetDoctorPermitService *request = [[GetDoctorPermitService alloc] initWithDocid:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"获得权限 %@",request.responseString);
        
        self.permitArray = request.responseJSONObject;
        [self.tableview reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"获得模板 %@",request.error);
    }];
    
}


-(void)changePermitWith:(BOOL )status who:(NSString *)who
{
    UpdatePermitService *request = [[UpdatePermitService alloc] initWithDocid:DoctorUserDefault.ID status:[NSString stringWithFormat:@"%d",status] who:who];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"更改权限 %@",request.responseString);

        [self getDoctorPermit];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"更改权限 %@",request.error);
    }];
    
}


// 获取排班表
-(void)getDoctorTime
{
    GetDoctorTimeService *request = [[GetDoctorTimeService alloc] initWithDocid:DoctorUserDefault.ID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"获取排班表 %@",request.responseString);
     
        self.timeArray = request.responseJSONObject;
       
        [self.tableview reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"更改权限 %@",request.error);
    }];
    
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



-(NSDictionary *)permitArray
{
    if (!_permitArray) {
        _permitArray  = [NSDictionary dictionary];
    }
    return _permitArray;
}


-(NSDictionary *)timeArray
{
    if (!_timeArray) {
        _timeArray  = [NSDictionary dictionary];
    }
    return _timeArray;
}


@end
