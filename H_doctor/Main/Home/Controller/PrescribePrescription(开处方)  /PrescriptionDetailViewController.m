//
//  PrescriptionDetailViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/2/1.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "PrescriptionDetailViewController.h"
#import "WRCellView.h"

@interface PrescriptionDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation PrescriptionDetailViewController

-(void)setNavBar
{
    [self.navigationView setTitle:self.title];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"作废" clickCallBack:^(UIView *view) {
        
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"作废" message:@"是否作废此处方？" preferredStyle:QMUIAlertControllerStyleAlert];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController showWithAnimated:YES];
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = AllBG;
    
    [self setNavBar];
    
    [self setupScorllView];
    
    [self setupSubViews];
    
    
}


-(void)setupScorllView
{
    
    UIScrollView *scoll = [[UIScrollView alloc] init];
    self.scrollView = scoll;
    scoll.showsVerticalScrollIndicator = NO;
    scoll.delegate = self;
    //    scoll.bounces = NO;
    
    
    [self.view addSubview:scoll];
    scoll.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).bottomEqualToView(self.view);
    
    

}


-(void)setupSubViews
{
    QMUILabel *title = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    title.backgroundColor = [UIColor whiteColor];
    title.text = @"河南科技大学第一附属医院（普通处方笺）全科";
    title.textAlignment = NSTextAlignmentCenter;
    
    [self.scrollView addSubview:title];
    
    title.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topEqualToView(self.scrollView).heightIs(34);
    
    
    //费别
    UIButton *treatment = [[UIButton alloc] init];
    [treatment setBackgroundColor:[UIColor whiteColor]];
    [treatment setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
    [treatment setTitle:@"费别" forState:UIControlStateNormal];
    [treatment setTitleColor:darkShenColor forState:UIControlStateNormal];
    treatment.titleLabel.font = PingFangFONT(14);
    [treatment lc_imageTitleHorizontalAlignmentWithSpace:5];
    treatment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    treatment.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
    
    QMUIButton *gongfei = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"gongfei_icon"] title:@"公费"];
    [gongfei setBackgroundColor:[UIColor whiteColor]];
    [gongfei setTitleColor:darkQianColor forState:UIControlStateNormal];
    gongfei.titleLabel.font = PingFangFONT(16);
    gongfei.spacingBetweenImageAndTitle = 10;
    gongfei.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    gongfei.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    QMUIButton *zifei = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"zifei_n_icon"] title:@"自费"];
    [zifei setBackgroundColor:[UIColor whiteColor]];
    [zifei setTitleColor:darkShenColor forState:UIControlStateNormal];
    zifei.titleLabel.font = PingFangFONT(16);
    zifei.spacingBetweenImageAndTitle = 10;
    zifei.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    zifei.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
    QMUIButton *yibao = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"yibao_icon"] title:@"医保"];
    [yibao setBackgroundColor:[UIColor whiteColor]];
    [yibao setTitleColor:darkQianColor forState:UIControlStateNormal];
    yibao.titleLabel.font = PingFangFONT(16);
    yibao.spacingBetweenImageAndTitle = 10;
    yibao.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    yibao.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
    QMUIButton *qita = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"qita_icon"] title:@"其他"];
    [qita setBackgroundColor:[UIColor whiteColor]];
    [qita setTitleColor:darkQianColor forState:UIControlStateNormal];
    qita.titleLabel.font = PingFangFONT(16);
    qita.spacingBetweenImageAndTitle = 10;
    qita.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    qita.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    UIImageView *selectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue_icon"]];
    [selectImage sizeToFit];
    
    [self.scrollView addSubview:treatment];
    [self.scrollView addSubview:gongfei];
    [self.scrollView addSubview:zifei];
    [self.scrollView addSubview:yibao];
    [self.scrollView addSubview:qita];
    [self.scrollView addSubview:selectImage];

    
    treatment.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(title, 10).rightEqualToView(self.scrollView).heightIs(44);
    
    gongfei.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(treatment, 0).heightIs(44);
    zifei.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(gongfei, 1).heightIs(44);
    
    yibao.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(zifei, 1).heightIs(44);
    
    qita.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(yibao, 1).heightIs(44);
    
    selectImage.sd_layout.rightSpaceToView(self.scrollView, 17).centerYEqualToView(zifei).widthIs(selectImage.width).heightIs(selectImage.height);
    
    
    
    //处方编号
    UIView *numberView = [[UIView alloc] init];
    numberView.backgroundColor = [UIColor whiteColor];
    
    QMUILabel *numberLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    numberLabel.text = @"处方编号";
    
    QMUILabel *numberText = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    numberText.text = @"20171109142406190";
    
    [self.scrollView addSubview:numberView];
    [numberView addSubview:numberLabel];
    [numberView addSubview:numberText];
    
    numberView.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(qita, 1).heightIs(50);
    
    numberLabel.sd_layout.leftSpaceToView(numberView, 15).centerYEqualToView(numberView).heightIs(numberLabel.font.lineHeight);
    [numberLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    numberText.sd_layout.rightSpaceToView(numberView, 15).centerYEqualToView(numberView).heightIs(numberText.font.lineHeight);
    [numberText setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    //基本资料
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    
    UIButton *infoBtn = [[UIButton alloc] init];
    [infoBtn setBackgroundColor:[UIColor whiteColor]];
    [infoBtn setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
    [infoBtn setTitle:@"基本资料" forState:UIControlStateNormal];
    [infoBtn setTitleColor:darkShenColor forState:UIControlStateNormal];
    infoBtn.titleLabel.font = PingFangFONT(14);
    [infoBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
    infoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    infoBtn.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
   
    
    QMUILabel *name = [[QMUILabel alloc] qmui_initWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0f] textColor:darkShenColor];
    name.text = @"黄晓晓";
    
    QMUILabel *sex = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    sex.text = @"男";
    
    QMUILabel *age = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    age.text = @"19岁";
    
    QMUILabel *marry = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    marry.text = @"婚姻：未知";
    
    QMUILabel *phone = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    phone.text = @"手机号： 13888888888";
    
    QMUILabel *IDCard = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    IDCard.text = @"身份证号：4222202222222222";
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 45;
    icon.layer.masksToBounds= YES;
    icon.image = [UIImage imageNamed:@"photo_icon"];
    
    
    [self.scrollView addSubview:infoView];
    [infoView addSubview:infoBtn];
    [infoView addSubview:name];
    [infoView addSubview:sex];
    [infoView addSubview:age];
    [infoView addSubview:marry];
    [infoView addSubview:phone];
    [infoView addSubview:IDCard];
    [infoView addSubview:icon];
    
    infoView.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(numberView, 1);
    infoBtn.sd_layout.leftEqualToView(infoView).topEqualToView(infoView).rightEqualToView(infoView).heightIs(44);
    
    name.sd_layout.leftSpaceToView(infoView, 15).topSpaceToView(infoBtn, 0).heightIs(name.font.lineHeight);
    [name setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    sex.sd_layout.leftSpaceToView(name, 29).bottomEqualToView(name).heightIs(sex.font.lineHeight);
    [sex setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    age.sd_layout.leftSpaceToView(sex, 30).bottomEqualToView(name).heightIs(age.font.lineHeight);
    [age setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    marry.sd_layout.leftEqualToView(name).topSpaceToView(name, 14).heightIs(marry.font.lineHeight);
    [marry setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    phone.sd_layout.leftEqualToView(name).topSpaceToView(marry, 14).heightIs(phone.font.lineHeight);
    [phone setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    IDCard.sd_layout.leftEqualToView(name).topSpaceToView(phone, 14).heightIs(IDCard.font.lineHeight);
    [IDCard setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    icon.sd_layout.topEqualToView(name).rightSpaceToView(infoView, 15).widthIs(90).heightIs(90);
    
    [infoView setupAutoHeightWithBottomView:IDCard bottomMargin:15];
    
    
    //就诊信息
    UIView *dataView = [[UIView alloc] init];
    dataView.backgroundColor = [UIColor whiteColor];
    
    UIButton *dataBtn = [[UIButton alloc] init];
    [dataBtn setBackgroundColor:[UIColor whiteColor]];
    [dataBtn setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
    [dataBtn setTitle:@"就诊信息" forState:UIControlStateNormal];
    [dataBtn setTitleColor:darkShenColor forState:UIControlStateNormal];
    dataBtn.titleLabel.font = PingFangFONT(14);
    [dataBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
    dataBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    dataBtn.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    
    
    QMUILabel *kebie = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    kebie.text = @"科别（病区/床位）：全科";
    
    QMUILabel *zhenduan = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    zhenduan.text = @"临床诊断：肠胃性感冒";
    
    QMUILabel *time = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    time.text = @"就诊时间：2017年11月23日  11:24:54";
    
    
    [self.scrollView addSubview:dataView];
    [dataView addSubview:dataBtn];
    [dataView addSubview:kebie];
    [dataView addSubview:zhenduan];
    [dataView addSubview:time];
    
    
    dataView.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(infoView, 1);
    dataBtn.sd_layout.leftEqualToView(dataView).topEqualToView(dataView).rightEqualToView(dataView).heightIs(44);
    
    kebie.sd_layout.leftSpaceToView(dataView, 15).topSpaceToView(dataBtn, 0).heightIs(kebie.font.lineHeight);
    [kebie setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    zhenduan.sd_layout.leftEqualToView(kebie).topSpaceToView(kebie, 15).heightIs(zhenduan.font.lineHeight);
    [zhenduan setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    time.sd_layout.leftEqualToView(zhenduan).topSpaceToView(zhenduan, 15).heightIs(time.font.lineHeight);
    [time setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    [dataView setupAutoHeightWithBottomView:time bottomMargin:15];
    
    
    //RP
    UIView *rpView = [[UIView alloc] init];
    rpView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:rpView];
    rpView.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(dataView, 1);
    
    
    UIButton *rpBtn = [[UIButton alloc] init];
    [rpBtn setBackgroundColor:[UIColor whiteColor]];
    [rpBtn setImage:[UIImage imageNamed:@"biaotitiaotiao_icon"] forState:UIControlStateNormal];
    [rpBtn setTitle:@"Rp" forState:UIControlStateNormal];
    [rpBtn setTitleColor:darkShenColor forState:UIControlStateNormal];
    rpBtn.titleLabel.font = PingFangFONT(14);
    [rpBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
    rpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rpBtn.contentEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(15), -AdaptedWidth(10), 0);
    [rpView addSubview:rpBtn];
    rpBtn.sd_layout.leftEqualToView(rpView).topEqualToView(rpView).rightEqualToView(rpView).heightIs(44);


   
    UIView *rpaView = [[UIView alloc] init];
    rpaView.backgroundColor = [UIColor whiteColor];
    [rpView addSubview:rpaView];
    rpaView.sd_layout.leftEqualToView(rpView).rightEqualToView(rpView).topSpaceToView(rpBtn, 0);

    
    NSArray *tempArray = @[@1,@2];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
   
//     MPWeakSelf(self)
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *rpView = [[UIView alloc] init];
        rpView.backgroundColor = [UIColor whiteColor];
        
        QMUILabel *title = [[QMUILabel alloc] qmui_initWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f] textColor:darkShenColor];
        title.text = @"1、阿达帕林凌胶";
        
        QMUILabel *dose = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
        dose.text = @"30g*1支/盒";
        
        QMUILabel *usage = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
        usage.text = @"sig:口服    用量：30g";
        
        QMUILabel *frequency = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
        frequency.text = @"DQ:QD|一天一次    共30天";
        
        QMUILabel *prescribed = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
        prescribed.text = @"医嘱：需要按时服药休息";
        
        
        [rpaView addSubview:rpView];
        [rpView addSubview:title];
        [rpView addSubview:dose];
        [rpView addSubview:usage];
        [rpView addSubview:frequency];
        [rpView addSubview:prescribed];
        
        
        title.sd_layout.leftSpaceToView(rpView, 15).topEqualToView(rpView).heightIs(title.font.lineHeight);
        [title setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
        
        dose.sd_layout.centerYEqualToView(title).rightSpaceToView(rpView, 15).heightIs(dose.font.lineHeight);
        [dose setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
        
        usage.sd_layout.leftEqualToView(title).topSpaceToView(title, 15).heightIs(usage.font.lineHeight);
        [usage setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
        
        frequency.sd_layout.leftEqualToView(title).topSpaceToView(usage, 15).heightIs(frequency.font.lineHeight);
        [frequency setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
        
        prescribed.sd_layout.leftEqualToView(title).topSpaceToView(frequency, 15).heightIs(prescribed.font.lineHeight);
        [prescribed setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
        
        
        
        [rpView setupAutoHeightWithBottomView:prescribed bottomMargin:15];  // 设置高度约束
        
        [temp addObject:rpView];
        
    }];
    
    
    [rpaView setupAutoWidthFlowItems:temp withPerRowItemsCount:1 verticalMargin:5 horizontalMargin:0 verticalEdgeInset:2 horizontalEdgeInset:0];
    
    [rpView setupAutoHeightWithBottomView:rpaView bottomMargin:0];
 
    
    //签名信息等
    WRCellView *autograph = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Icon];
    autograph.leftLabel.text = @"签名";
    autograph.rightIcon.image = [UIImage imageNamed:@"photo_icon"];
    
    WRCellView *doctor = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
    doctor.leftLabel.text = @"医师";
    doctor.rightLabel.text = @"张医生";
    doctor.rightLabel.textColor = darkShenColor;
    
    WRCellView *price = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
    price.leftLabel.text = @"药品金额";
    price.rightLabel.text = @"¥ 206.20";
    price.rightLabel.textColor = [UIColor redColor];
    
    WRCellView *doctor2 = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
    doctor2.leftLabel.text = @"审核医师";
    doctor2.rightLabel.text = @"张医生";
    doctor2.rightLabel.textColor = darkShenColor;
    
    WRCellView *doctor3 = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
    doctor3.leftLabel.text = @"调配医师/士";
    doctor3.rightLabel.text = @"张医生";
    doctor3.rightLabel.textColor = darkShenColor;
    
    WRCellView *doctor4 = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
    doctor4.leftLabel.text = @"核对、发药医师";
    doctor4.rightLabel.text = @"张医生";
    doctor4.rightLabel.textColor = darkShenColor;
    
    
    [self.scrollView addSubview:autograph];
    [self.scrollView addSubview:doctor];
    [self.scrollView addSubview:price];
    [self.scrollView addSubview:doctor2];
    [self.scrollView addSubview:doctor3];
    [self.scrollView addSubview:doctor4];
    
    autograph.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(rpView, 10).heightIs(90);
    doctor.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(autograph, 0).heightIs(44);
    price.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(doctor, 0).heightIs(44);
    doctor2.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(price, 0).heightIs(44);
    doctor3.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(doctor2, 0).heightIs(44);
    doctor4.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topSpaceToView(doctor3, 0).heightIs(44);
    
    
    [self.scrollView setupAutoContentSizeWithBottomView:doctor4 bottomMargin:0];

    
}










@end
