//
//  TimeSelectViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/18.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "TimeSelectViewController.h"
#import "GetDoctorTime_SystemService.h"
#import "SaveDoctorTimeService.h"

@interface TimeSelectViewController ()

@property (nonatomic,strong) UIButton *timeSlotA;
@property (nonatomic,strong) UIButton *timeSlotB;
@property (nonatomic,strong) UIButton *timeSlotC;
@property (nonatomic,strong) UIButton *timeSlotD;

@property (nonatomic,strong) NSDictionary *timeArray;

@end

@implementation TimeSelectViewController

-(void)setNavBar
{
    [self.navigationView setTitle:self.titleName];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"保存" clickCallBack:^(UIView *view) {
        
        [weakself saveTime];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AllBG;
    
    [self setNavBar];
    
    [self GetDoctorTime_System];
}



-(void)setupSubViews
{
    
    QMUILabel *tip = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(15) textColor:darkShenColor];
    tip.text = @"请选择上班时间（最多可同时选择4个）";
    tip.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    
    
    UIButton *timeSlotA = [[UIButton alloc] init];
    self.timeSlotA = timeSlotA;
    [timeSlotA setBackgroundImage:[UIImage imageNamed:@"one_two"] forState:UIControlStateNormal];
    [timeSlotA setBackgroundImage:[UIImage imageNamed:@"one_one"] forState:UIControlStateSelected];
    [timeSlotA setBackgroundImage:[UIImage imageNamed:@"one_three"] forState:UIControlStateDisabled];
    [timeSlotA setTitle:[NSString stringWithFormat:@"%@-%@",self.timeArray[@"ds"][0][@"starttime"],self.timeArray[@"ds"][0][@"endtime"]] forState:UIControlStateNormal];
    [timeSlotA addTarget:self action:@selector(didClickA) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *timeSlotB = [[UIButton alloc] init];
    self.timeSlotB = timeSlotB;
    [timeSlotB setBackgroundImage:[UIImage imageNamed:@"two_two"] forState:UIControlStateNormal];
    [timeSlotB setBackgroundImage:[UIImage imageNamed:@"two_one"] forState:UIControlStateSelected];
    [timeSlotB setBackgroundImage:[UIImage imageNamed:@"two_three"] forState:UIControlStateDisabled];
    [timeSlotB setTitle:[NSString stringWithFormat:@"%@-%@",self.timeArray[@"ds"][1][@"starttime"],self.timeArray[@"ds"][1][@"endtime"]]  forState:UIControlStateNormal];
    [timeSlotB addTarget:self action:@selector(didClickB) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *timeSlotC = [[UIButton alloc] init];
    self.timeSlotC = timeSlotC;
    [timeSlotC setBackgroundImage:[UIImage imageNamed:@"three_two"] forState:UIControlStateNormal];
    [timeSlotC setBackgroundImage:[UIImage imageNamed:@"three_one"] forState:UIControlStateSelected];
    [timeSlotC setBackgroundImage:[UIImage imageNamed:@"three_three"] forState:UIControlStateDisabled];
    [timeSlotC setTitle:[NSString stringWithFormat:@"%@-%@",self.timeArray[@"ds"][2][@"starttime"],self.timeArray[@"ds"][2][@"endtime"]]  forState:UIControlStateNormal];
    [timeSlotC addTarget:self action:@selector(didClickC) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *timeSlotD = [[UIButton alloc] init];
    self.timeSlotD = timeSlotD;
    [timeSlotD setBackgroundImage:[UIImage imageNamed:@"four_two"] forState:UIControlStateNormal];
    [timeSlotD setBackgroundImage:[UIImage imageNamed:@"four_one"] forState:UIControlStateSelected];
    [timeSlotD setBackgroundImage:[UIImage imageNamed:@"four_three"] forState:UIControlStateDisabled];
    [timeSlotD setTitle:[NSString stringWithFormat:@"%@-%@",self.timeArray[@"ds"][3][@"starttime"],self.timeArray[@"ds"][3][@"endtime"]]  forState:UIControlStateNormal];
    [timeSlotD addTarget:self action:@selector(didClickD) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tip];
    [self.view addSubview:timeSlotA];
    [self.view addSubview:timeSlotB];
    [self.view addSubview:timeSlotC];
    [self.view addSubview:timeSlotD];
    
    
    tip.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).heightIs(50);
    
    timeSlotA.sd_layout.leftEqualToView(self.view).topSpaceToView(tip, 0).rightEqualToView(self.view).heightIs(100);
    
      timeSlotB.sd_layout.leftEqualToView(self.view).topSpaceToView(timeSlotA, 10).rightEqualToView(self.view).heightIs(100);
    
      timeSlotC.sd_layout.leftEqualToView(self.view).topSpaceToView(timeSlotB, 10).rightEqualToView(self.view).heightIs(100);
    
      timeSlotD.sd_layout.leftEqualToView(self.view).topSpaceToView(timeSlotC, 10).rightEqualToView(self.view).heightIs(100);
    
}


-(void)didClickA
{
    self.timeSlotA.selected = !self.timeSlotA.selected;
    
}


-(void)didClickB
{
    self.timeSlotB.selected = !self.timeSlotB.selected;
    
}

-(void)didClickC
{
    self.timeSlotC.selected = !self.timeSlotC.selected;
    
}

-(void)didClickD
{
    self.timeSlotD.selected = !self.timeSlotD.selected;
    
}





#pragma mark 网络

-(void)GetDoctorTime_System
{
    GetDoctorTime_SystemService *request = [[GetDoctorTime_SystemService alloc] init];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"获取排班表时间 %@",request.responseString);
        
        self.timeArray = request.responseJSONObject;
        
        [self setupSubViews];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"获取排班表时间 %@",request.error);
    }];
 
}



-(void)saveTime
{
    NSMutableArray *time = [NSMutableArray array];
    if (self.timeSlotA.selected == YES) {
        [time addObject:self.timeSlotA.titleLabel.text];
    }
    if (self.timeSlotB.selected == YES) {
        [time addObject:self.timeSlotB.titleLabel.text];
    }
    if (self.timeSlotC.selected == YES) {
        [time addObject:self.timeSlotC.titleLabel.text];
    }
    if (self.timeSlotD.selected == YES) {
        [time addObject:self.timeSlotC.titleLabel.text];
    }
    
    
    
    SaveDoctorTimeService *request = [[SaveDoctorTimeService alloc] initWithDocid:DoctorUserDefault.ID weekid:self.weekid timecollection:[time componentsJoinedByString:@","]];
    
    NSLog(@" %@",request);
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                NSLog(@"保存排班表时间 %@",request.responseString);
        
        [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"保存排班表时间 %@",request.error);
    }];
    
}





#pragma mark 懒加载

-(NSDictionary *)timeArray
{
    if (!_timeArray) {
        _timeArray  = [NSDictionary dictionary];
    }
    return _timeArray;
}

@end
