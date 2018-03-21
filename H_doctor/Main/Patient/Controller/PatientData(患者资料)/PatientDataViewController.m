//
//  PatientDataViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/24.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "PatientDataViewController.h"
#import "ContactRecordViewController.h"
#import "GetPatientInfoService.h"

@interface PatientDataViewController ()

@property (nonatomic,strong) NSDictionary *dic;

@end

@implementation PatientDataViewController


-(void)setNavBar
{
    [self.navigationView setTitle:@"患者资料"];
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AllBG;
    
    [self setNavBar];
    
    [self GetSignSickerAllInquiry];
    
}


-(void)setupSubViews
{
    QMUILabel *dataLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(15) textColor:darkzhongColor];
    dataLabel.text = @"基本资料";
    
    [self.view addSubview:dataLabel];
    
    dataLabel.sd_layout.leftSpaceToView(self.view, 16).topSpaceToView(self.view, 64+18).heightIs(dataLabel.font.lineHeight);
    [dataLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    // dataView
    UIView *dataView = [[UIView alloc] init];
    dataView.backgroundColor = [UIColor whiteColor];
    
    
    QMUILabel *name = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    name.text = [NSString stringWithFormat:@"真实姓名：%@",self.dic[@"userinfo"][@"realname"]];
    
    QMUILabel *sex = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    sex.text = [NSString stringWithFormat:@"性别：      %@",self.dic[@"userinfo"][@"gender"]];
    
    QMUILabel *age = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    age.text = [NSString stringWithFormat:@"年龄：      %@岁",self.dic[@"userinfo"][@"age"]];
    
    QMUILabel *marry = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    marry.text = [NSString stringWithFormat:@"婚姻：      %@",self.dic[@"userinfo"][@"marriage"]];
    
    QMUILabel *phone = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    phone.text = [NSString stringWithFormat:@"手机号：   %@",self.dic[@"userinfo"][@"tel"]];
    
    QMUILabel *IDCard = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    IDCard.text = [NSString stringWithFormat:@"身份证号：%@",self.dic[@"userinfo"][@"sfzcode"]];;
    
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 45;
    icon.layer.masksToBounds = YES;
    [icon sd_setImageWithURL:[NSURL URLWithString:self.dic[@"userinfo"][@"img"]] placeholderImage:[UIImage imageNamed:@"header_icon_line"]];
    
    [self.view addSubview:dataView];
    [dataView addSubview:name];
    [dataView addSubview:sex];
    [dataView addSubview:age];
    [dataView addSubview:marry];
    [dataView addSubview:phone];
    [dataView addSubview:IDCard];
    [dataView addSubview:icon];
    
    dataView.sd_layout.leftSpaceToView(self.view, 15).rightSpaceToView(self.view, 15).topSpaceToView(dataLabel, 10);
    
    name.sd_layout.leftSpaceToView(dataView, 18).topSpaceToView(dataView, 20).heightIs(name.font.lineHeight);
    [name setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    sex.sd_layout.leftEqualToView(name).topSpaceToView(name, 14).heightIs(sex.font.lineHeight);
    [sex setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    age.sd_layout.leftEqualToView(name).topSpaceToView(sex, 14).heightIs(age.font.lineHeight);
    [age setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    marry.sd_layout.leftEqualToView(name).topSpaceToView(age, 14).heightIs(marry.font.lineHeight);
    [marry setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    phone.sd_layout.leftEqualToView(name).topSpaceToView(marry, 14).heightIs(phone.font.lineHeight);
    [phone setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    IDCard.sd_layout.leftEqualToView(name).topSpaceToView(phone, 14).heightIs(IDCard.font.lineHeight);
    [IDCard setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    icon.sd_layout.rightSpaceToView(dataView, 17).topSpaceToView(dataView, 19).widthIs(90).heightIs(90);
    
    [dataView setupAutoHeightWithBottomView:IDCard bottomMargin:20];
    
    
    
    // 接诊记录
    
    QMUILabel *recordLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(15) textColor:darkzhongColor];
    recordLabel.text = @"最近接诊记录";
    
    QMUIButton *allRecord = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"gengduo_icon"] title:@"查看所有记录"];
    allRecord.titleLabel.font = PingFangFONT(13);
    [allRecord setTitleColor:darkzhongColor forState:UIControlStateNormal];
    allRecord.imagePosition = QMUIButtonImagePositionRight;
    allRecord.spacingBetweenImageAndTitle = 2;
    [allRecord addTarget:self action:@selector(didClickRecord) forControlEvents:UIControlEventTouchUpInside];
    [allRecord sizeToFit];
    
    
    // 接诊模式
    UILabel *type = [[UILabel alloc] init];
    type.font = [UIFont fontWithName:@"PingFang SC-Bold" size:35.0f];;
    type.textColor = darkShenColor;
    type.text = self.dic[@"lastinquiry"][@"typename"];
    
    
    
    UIView *recordView = [[UIView alloc] init];
    recordView.backgroundColor = [UIColor whiteColor];
    
    // 姓名
    UILabel *recordName = [[UILabel alloc] init];
    recordName.font = PingFangFONT(16);
    recordName.textColor = darkzhongColor;
    recordName.text = self.dic[@"lastinquiry"][@"dstname"];
    
    
    // 个人信息
    UILabel *data = [[UILabel alloc] init];
    data.font = PingFangFONT(14);
    data.textColor = darkQianColor;
    if (self.dic[@"lastinquiry"][@"dstgender"] == nil && self.dic[@"lastinquiry"][@"dsttel"] == nil) {
        data.text = @"";
    }else{
        data.text = [NSString stringWithFormat:@"%@   %@",self.dic[@"lastinquiry"][@"dstgender"],self.dic[@"lastinquiry"][@"dsttel"]];
    }
    
    
    // 进行状态
    UILabel *state = [[UILabel alloc] init];
    state.font = PingFangFONT(16);
    state.textColor = RGB(72,147,245);
    state.text = self.dic[@"lastinquiry"][@"statusname"];
    
    
    // 处方结果
    UILabel *result = [[UILabel alloc] init];
    result.font = PingFangFONT(16);
    result.textColor = darkzhongColor;
    result.text = self.dic[@"lastinquiry"][@"chufangname"];
    
    
    // 时间
    UILabel *date = [[UILabel alloc] init];
    date.font = PingFangFONT(14);
    date.textColor = darkQianColor;
    date.text = self.dic[@"lastinquiry"][@"starttime"];

    
    
    [self.view addSubview:recordLabel];
    [self.view addSubview:allRecord];
    [self.view addSubview:recordView];
    [recordView addSubview:type];
    [recordView addSubview:recordName];
    [recordView addSubview:data];
    [recordView addSubview:state];
    [recordView addSubview:result];
    [recordView addSubview:date];
    
    
    recordLabel.sd_layout.leftSpaceToView(self.view, 16).topSpaceToView(dataView, 20).heightIs(recordLabel.font.lineHeight);
    [recordLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    allRecord.sd_layout.rightSpaceToView(self.view, 16).centerYEqualToView(recordLabel).widthIs(allRecord.width).heightIs(allRecord.height);
    
    
    recordView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(recordLabel, 10);
    
    
    type.sd_layout.leftSpaceToView(recordView, 15).topSpaceToView(recordView, 15).heightIs(type.font.lineHeight);
    [type setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    recordName.sd_layout.leftEqualToView(type).topSpaceToView(type, 15).heightIs(recordName.font.lineHeight);
    [recordName setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    data.sd_layout.leftEqualToView(recordName).topSpaceToView(recordName, 10).heightIs(data.font.lineHeight);
    [data setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    state.sd_layout.centerYEqualToView(type).rightSpaceToView(recordView, 15).heightIs(state.font.lineHeight);
    [state setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    result.sd_layout.topSpaceToView(state, 15).rightEqualToView(state).heightIs(result.font.lineHeight);
    [result setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    date.sd_layout.topSpaceToView(result, 15).rightEqualToView(result).heightIs(date.font.lineHeight);
    [date setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    [recordView setupAutoHeightWithBottomView:date bottomMargin:16];

    
    //发起会话
    UIButton *save = [[UIButton alloc] init];
    [save setBackgroundImage:[UIImage imageNamed:@"sign_s"] forState:UIControlStateNormal];
    [save setTitle:@"发起会话" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    save.titleLabel.font = PingFangFONT(18);
    [save addTarget:self action:@selector(didClickChat) forControlEvents:UIControlEventTouchUpInside];
    [save sizeToFit];
    
    [self.view addSubview:save];
    
     save.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, 40).widthIs(save.width).heightIs(save.height);
    
}


// 发起会话
-(void)didClickChat
{
    
    
    
}




-(void)didClickRecord
{
    ContactRecordViewController *record = [[ContactRecordViewController alloc] init];
    record.userId = self.dic[@"lastinquiry"][@"id"];
    [self.navigationController pushViewController:record animated:YES];
}



#pragma mark 网络

-(void)GetSignSickerAllInquiry
{
    NSLog(@" %@",self.patientId);
    GetPatientInfoService *request = [[GetPatientInfoService alloc] initWithDocid:self.patientId];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"患者详情 %@",request.responseString);
        
        self.dic = request.responseJSONObject;
        
        [self setupSubViews];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"患者详情 %@",request.error);
    }];
    
}




#pragma mark 懒加载

-(NSDictionary *)dic
{
    if (!_dic) {
        _dic = [NSDictionary dictionary];
    }
    return _dic;
}



@end
