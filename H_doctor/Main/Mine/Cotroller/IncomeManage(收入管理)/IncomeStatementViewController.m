//
//  IncomeStatementViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/22.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "IncomeStatementViewController.h"

@interface IncomeStatementViewController ()

@end

@implementation IncomeStatementViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"收入说明"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    

    UILabel *statement = [[UILabel alloc] init];
    statement.font = PingFangFONT(15);
    statement.textColor = darkShenColor;
    statement.text = @"收入说明";
    
    [self.view addSubview:statement];
    
    
    statement.sd_layout.leftSpaceToView(self.view, 16).rightSpaceToView(self.view, 16).topSpaceToView(self.view, 28+64).autoHeightRatio(0);
    
}






@end
