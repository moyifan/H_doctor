//
//  Anaphylaxis  ViewController.m
//  H_doctor
//
//  Created by zhiren on 2018/1/26.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AnaphylaxisViewController.h"
#import "ShuruViewController.h"

@interface AnaphylaxisViewController ()

@property (nonatomic,strong) UIView *tipView;
@property (nonatomic,strong) NSMutableArray *anaphyArray;
@property (nonatomic,strong) QMUIFloatLayoutView *btnView;

@end

@implementation AnaphylaxisViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"药品过敏史"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"确定" clickCallBack:^(UIView *view) {
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = AllBG;
    
    [self setNavBar];

    [self setupSubViews];
    
    [self setBtnView];
}



-(void)setupSubViews
{
    UIView *tipView = [[UIView alloc] init];
    self.tipView = tipView;
    
    UIImageView *tipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guominshi_icon"]];
    [tipImage sizeToFit];
    
    QMUILabel *tipLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkQianColor];
    tipLabel.text = @"当前没有过敏药品！";
    
    [self.view addSubview:tipView];
    [tipView addSubview:tipImage];
    [tipView addSubview:tipLabel];
    
    tipView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).widthIs(150);
    
    tipImage.sd_layout.centerXEqualToView(tipView).topEqualToView(tipView).widthIs(tipImage.width).heightIs(tipImage.height);
    
    tipLabel.sd_layout.centerXEqualToView(tipView).topSpaceToView(tipImage, 34).heightIs(tipLabel.font.lineHeight);
    [tipLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    [tipView setupAutoHeightWithBottomView:tipLabel bottomMargin:0];
    
    
    
    //
    QMUIButton *add = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"add_icon"] title:@"添加过敏药品"];
    [add setTitleColor:RGB(72,147,245) forState:UIControlStateNormal];
    add.titleLabel.font = PingFangFONT(16);
    [add setBackgroundColor:[UIColor whiteColor]];
    add.spacingBetweenImageAndTitle = 5;
    [add addTarget:self action:@selector(didClickAdd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:add];
    
    add.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
    
}



-(void)didClickAdd
{
    MPWeakSelf(self)
    ShuruViewController *shu = [[ShuruViewController alloc] init];
    shu.titleShu = @"添加过敏药品";
    [self.navigationController pushViewController:shu animated:YES];
    
    if (!shu.backClickedBlock) {
        [shu setBackClickedBlock:^(NSString *content) {
            [weakself.anaphyArray addObject:content];
            [weakself setBtnView];
        }];
    }
    
}




-(void)setBtnView
{
    if ([self.anaphyArray isEqualToArray:@[]] || self.anaphyArray == nil) {

        self.tipView.hidden = NO;
        
        if (self.btnView != nil) {
            [self.btnView removeFromSuperview];
        }
        
        return;
    }else{
        self.tipView.hidden = YES;
    }
    
    
    [self.btnView qmui_removeAllSubviews];
    
   
    
    for (NSInteger i = 0; i < self.anaphyArray.count; i++) {
        QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
        button.ghostColor = RGB(137,167,206);
        [button setBackgroundColor:RGB(243,250,255)];
        [button setTitle:self.anaphyArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = PingFangFONT(15);
        button.contentEdgeInsets = UIEdgeInsetsMake(7, 15, 7, 15);
        [button setImage:[UIImage imageNamed:@"search_delete"] forState:UIControlStateNormal];
        button.imagePosition = QMUIButtonImagePositionRight;
        button.spacingBetweenImageAndTitle = 8;
        [button addTarget:self action:@selector(didClickDelet:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 7777+i;
        
        [_btnView addSubview:button];
    }
    
    
    [self.view addSubview:_btnView];
    
    
    CGSize keshiSize = [_btnView sizeThatFits:CGSizeMake(self.view.width, CGFLOAT_MAX)];
    _btnView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).heightIs(keshiSize.height);
    
//    [footView setupAutoHeightWithBottomView:btnView bottomMargin:15];
    
    
}



-(void)didClickDelet:(UIButton *)sender
{
    [self.anaphyArray removeObjectAtIndex:sender.tag-7777];
    
    [self setBtnView];
    
}





-(NSMutableArray *)anaphyArray
{
    if (!_anaphyArray) {
        _anaphyArray = [NSMutableArray array];
    }
    return _anaphyArray;
}


-(QMUIFloatLayoutView *)btnView
{
    if (!_btnView) {
        
        _btnView = [[QMUIFloatLayoutView alloc] init];
        _btnView.backgroundColor = [UIColor whiteColor];
        _btnView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
        _btnView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
        _btnView.minimumItemSize = CGSizeMake(69, 29);// 以2个字的按钮作为最小宽度
    }
    return _btnView;
}


@end
