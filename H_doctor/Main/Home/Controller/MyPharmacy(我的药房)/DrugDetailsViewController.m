//
//  DrugDetailsViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/2/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "DrugDetailsViewController.h"

@interface DrugDetailsViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;


@end

@implementation DrugDetailsViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"药品详情"];
    
//    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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

    // 
    UIImageView *icon = [[UIImageView alloc] init];
    [icon sd_setImageWithURL:[NSURL URLWithString:self.model.img] placeholderImage:[UIImage imageNamed:@"pic_drug___"]];
    
    QMUILabel *drugTitle = [[QMUILabel alloc] qmui_initWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f] textColor:darkShenColor];
    drugTitle.text = self.model.medcname;
    
    
    QMUILabel *drugDetail = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkQianColor];
    drugDetail.text = self.model.factoryname;
    
    NSString *priceText = [NSString stringWithFormat:@"参考价格：%.2f元",self.model.price];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:priceText];
    
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(16) range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(16) range:NSMakeRange(priceText.length-1, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:darkShenColor range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:darkShenColor range:NSMakeRange(priceText.length-1, 1)];
    
    //8888-80 text-style1
    [attributedString addAttribute:NSFontAttributeName value:PingFangFONT(23) range:NSMakeRange(5, priceText.length-6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, priceText.length-6)];
    
    
    UILabel *price = [[UILabel alloc] init];
    price.attributedText = attributedString;
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    
    
    
    [self.scrollView addSubview:icon];
    [self.scrollView addSubview:drugTitle];
    [self.scrollView addSubview:drugDetail];
    [self.scrollView addSubview:price];
    [self.scrollView addSubview:line];

    
    icon.sd_layout.leftSpaceToView(self.scrollView, 15).topSpaceToView(self.scrollView, 22).widthIs(120).heightIs(120);
    
    
    drugTitle.sd_layout.topEqualToView(icon).leftSpaceToView(icon, 18).rightSpaceToView(self.scrollView, 28).autoHeightRatio(0);
    [drugTitle setMaxNumberOfLinesToShow:2];
    
    
    drugDetail.sd_layout.leftEqualToView(drugTitle).topSpaceToView(drugTitle, 17).rightEqualToView(drugTitle).autoHeightRatio(0);
    [drugDetail setMaxNumberOfLinesToShow:2];
    
    
    price.sd_layout.bottomEqualToView(icon).rightSpaceToView(self.scrollView, 15).heightIs(price.font.lineHeight);
    price.isAttributedContent = YES;
    [price setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    line.sd_layout.leftEqualToView(icon).rightEqualToView(drugTitle).heightIs(1).topSpaceToView(icon, 22);
    
    
    // 批准文号
    NSString *approvalNumberText = [NSString stringWithFormat:@"【批准文号】：%@",self.model.wenhao];
    NSMutableAttributedString *approvalAttStr = [[NSMutableAttributedString alloc] initWithString:approvalNumberText];
    
    [approvalAttStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f] range:NSMakeRange(0, 6)];
    [approvalAttStr addAttribute:NSFontAttributeName value:PingFangFONT(14) range:NSMakeRange(6, approvalNumberText.length-6)];

    
    
    UILabel *approval = [[UILabel alloc] init];
    approval.textColor = darkShenColor;
    approval.attributedText = approvalAttStr;
    
    [self.scrollView addSubview:approval];
    
    approval.sd_layout.leftSpaceToView(self.scrollView, 15).rightSpaceToView(self.scrollView, 15).topSpaceToView(line, 20).autoHeightRatio(0);
    approval.isAttributedContent = YES;
    
    
    //生产企业
    NSString *enterpriseText = [NSString stringWithFormat:@"【生产企业】：%@",self.model.factoryname];
    NSMutableAttributedString *enterpriseAttStr = [[NSMutableAttributedString alloc] initWithString:enterpriseText];
    
    [enterpriseAttStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f] range:NSMakeRange(0, 6)];
    [enterpriseAttStr addAttribute:NSFontAttributeName value:PingFangFONT(14) range:NSMakeRange(6, enterpriseText.length-6)];
    
    
    
    UILabel *enterprise = [[UILabel alloc] init];
    enterprise.textColor = darkShenColor;
    enterprise.attributedText = enterpriseAttStr;
    
    [self.scrollView addSubview:enterprise];
    
    enterprise.sd_layout.leftSpaceToView(self.scrollView, 15).rightSpaceToView(self.scrollView, 15).topSpaceToView(approval, 20).autoHeightRatio(0);
    enterprise.isAttributedContent = YES;
    
   
    // 功能主治
    NSString *functionText = [NSString stringWithFormat:@"【功能主治】：%@",self.model.zhuzhi];
    NSMutableAttributedString *functionAttStr = [[NSMutableAttributedString alloc] initWithString:functionText];
    
    [functionAttStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f] range:NSMakeRange(0, 6)];
    [functionAttStr addAttribute:NSFontAttributeName value:PingFangFONT(14) range:NSMakeRange(6, functionText.length-6)];
    
    
    
    UILabel *function = [[UILabel alloc] init];
    function.textColor = darkShenColor;
    function.attributedText = functionAttStr;
    
    [self.scrollView addSubview:function];
    
    function.sd_layout.leftSpaceToView(self.scrollView, 15).rightSpaceToView(self.scrollView, 15).topSpaceToView(enterprise, 20).autoHeightRatio(0);
    function.isAttributedContent = YES;
    
    
    //主要成分
    NSString *componentText = [NSString stringWithFormat:@"【主要成分】：%@",self.model.chengfen];
    NSMutableAttributedString *componentAttStr = [[NSMutableAttributedString alloc] initWithString:componentText];
    
    [componentAttStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f] range:NSMakeRange(0, 6)];
    [componentAttStr addAttribute:NSFontAttributeName value:PingFangFONT(14) range:NSMakeRange(6, componentText.length-6)];
    
    
    
    UILabel *component = [[UILabel alloc] init];
    component.textColor = darkShenColor;
    component.attributedText = componentAttStr;
    
    [self.scrollView addSubview:component];
    
    component.sd_layout.leftSpaceToView(self.scrollView, 15).rightSpaceToView(self.scrollView, 15).topSpaceToView(function, 20).autoHeightRatio(0);
    component.isAttributedContent = YES;
    
    
    // 注意事项
    UILabel *careful = [[UILabel alloc] init];
    careful.textColor = darkShenColor;
    careful.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    careful.text = @"【注意事项】:";
    [self.scrollView addSubview:careful];
    
    
    UIView *carefulView = [[UIView alloc] init];
    carefulView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:carefulView];
    
    
    NSMutableArray *temp = [[NSMutableArray alloc]init];
//    NSArray *array = [self.medicinelModel.medicine.attention componentsSeparatedByString:@"。"];
    NSArray *array = [self.model.attention componentsSeparatedByString:@"\n"];
    

    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *carefulLabel = [[UILabel alloc]init];
        carefulLabel.textColor = darkzhongColor;
        carefulLabel.font = AdaptedFontSize(14);
        carefulLabel.numberOfLines = 0;
        
        //        carefulLabel.text = [NSString stringWithFormat:@"%lu. %@",(unsigned long)idx,obj];
//        carefulLabel.text = [NSString stringWithFormat:@"%@",obj];
        carefulLabel.text = [NSString stringWithFormat:@"%@",obj];
        [carefulLabel sizeToFit];
        
        
        [carefulView addSubview:carefulLabel];
        carefulLabel.sd_layout.autoHeightRatio(0);// 设置高度约束
        
        [temp addObject:carefulLabel];
        
    }];
    
    
    
    carefulView.sd_layout.leftSpaceToView(self.scrollView, 20).rightSpaceToView(self.scrollView, 15).topSpaceToView(careful, 10);
    
    
    // 此步设置之后fatherView的高度可以根据子view自适应
    /*
     设置类似collectionView效果的固定宽带自动间距浮动子view viewsArray : 需要浮动布局的所有视图 perRowItemsCount : 每行显示的视图个数 verticalMargin : 视图之间的垂直间距 vInset : 上下缩进值 hInset : 左右缩进值
     */
    //如果count<总的view，就会分多行显示
    [carefulView setupAutoWidthFlowItems:temp withPerRowItemsCount:1 verticalMargin:5 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    
    
    
    
    careful.sd_layout.leftSpaceToView(self.scrollView, 15).topSpaceToView(component, 20).heightIs(careful.font.lineHeight);
    [careful setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    
    [self.scrollView setupAutoContentSizeWithBottomView:carefulView bottomMargin:20];

    
}



@end
