//
//  ShuruViewController.m
//  hospital
//
//  Created by zhiren on 2017/7/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "ShuruViewController.h"

@interface ShuruViewController ()<UITextViewDelegate>

@end

@implementation ShuruViewController
{
    UITextView *_shuru;
}


-(void)setNavBar
{
    [self.navigationView setTitle:self.titleShu];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
  
    [self.navigationView addRightButtonWithTitle:@"提交" clickCallBack:^(UIView *view) {

        [weakself didClickPost];
        [weakself.navigationController popViewControllerAnimated:YES];
        
    }];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去除导航栏高度
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = backBG;
    
    [self setNavBar];
    
    [self setupSubViews];
}


-(void)setupSubViews
{
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];

    _shuru = [[UITextView alloc] init];
    _shuru.textColor = darkzhongColor;
    _shuru.font = PingFangFONT(16);
    _shuru.delegate = self;

    [self.view addSubview:back];
    [back addSubview:_shuru];

    back.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).heightIs(AdaptedWidth(44));
    
    _shuru.sd_layout.leftSpaceToView(back, 15).rightSpaceToView(back, 15).topSpaceToView(back, 5).bottomSpaceToView(back, 5);
}

-(void)didClickPost
{
    if (self.backClickedBlock) {
        
        self.backClickedBlock(_shuru.text);
    }
    
}


//-(void)dealloc
//{
//    [_shuru removeFromSuperview];
//}




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        return NO;
    }
    return YES;
}






@end
