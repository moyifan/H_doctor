//
//  BeGoodViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "BeGoodViewController.h"
#import "PlaceholderTextView.h"


@interface BeGoodViewController ()<UITextViewDelegate>
@property (nonatomic, strong) PlaceholderTextView * textView;

@end

@implementation BeGoodViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"修改擅长"];
    
    
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
    
    self.view.backgroundColor = RGB(242, 246, 250);
    
    [self setNavBar];
    
    [self.view addSubview:self.textView];
    
    self.textView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).offset(64).rightEqualToView(self.view).heightIs(216);
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    //在输入过程中 判断加上输入的字符 是否超过限定字数
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > 100)
    {
        textView.text = [textView.text substringToIndex:100];
        return NO;
    }
    
    return YES;
}


-(void)didClickPost
{
    if (self.backClickedBlock) {
        
        self.backClickedBlock(_textView.text);
    }
    
}



#pragma mark 懒加载
-(PlaceholderTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = AdaptedFontSize(14);
        _textView.textColor = darkShenColor;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        
        _textView.placeholderColor = darkQianColor;
        _textView.placeholder = @"请输入您的擅长。";
    }
    
    return _textView;
}

@end
