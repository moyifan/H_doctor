//
//  MMChatInputView.m
//  H_doctor
//
//  Created by zhiren on 2018/3/8.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "MMChatInputView.h"
#import "LQIMInputView.h"

@interface MMChatInputView () <UITextViewDelegate>

@property(nonatomic,strong) LQIMInputView *inputView;

@end


@implementation MMChatInputView

-(instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];

        [self setupSubViews];
        
    }
    
    return self;
}


-(void)setupSubViews
{
    
    // 加号按钮
//    UIButton *open = [[UIButton alloc] init];
//    [open setBackgroundImage:[UIImage imageNamed:@"gongneng_icon"] forState:UIControlStateNormal];
//    [open sizeToFit];
//
//    [self addSubview:open];
//
//    open.sd_layout.centerYEqualToView(self).leftSpaceToView(self, 16).widthIs(open.width).heightIs(open.height);
    
    
    //输入框
    self.textViewInput = [[UITextView alloc] init];
    self.textViewInput.layer.cornerRadius = 4;
    self.textViewInput.layer.masksToBounds = YES;
    self.textViewInput.delegate = self;
    self.textViewInput.layer.borderWidth = 1;
    self.textViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    self.textViewInput.returnKeyType = UIReturnKeySend;
    [self addSubview:self.textViewInput];
    
    self.textViewInput.sd_layout.leftSpaceToView(self, 16).centerYEqualToView(self).rightSpaceToView(self, 15).heightIs(36);
    
    
    
//    self.inputView = [[LQIMInputView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-210, [UIScreen mainScreen].bounds.size.width, 210)];
//    self.inputView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
//    [self.inputView addItem:[InputItemModel initWithTitle:@"结束问诊" imageName:@"jieshuwenzhen_icon" clickedBlock:^{
//        NSLog(@"相册");
//    }]];
//    [self.inputView addItem:[InputItemModel initWithTitle:@"拍照" imageName:@"zhaoxian" clickedBlock:^{
//        NSLog(@"拍照");
//    }]];
//    [self.inputView addItem:[InputItemModel initWithTitle:@"加价" imageName:@"jiajia" clickedBlock:^{
//        NSLog(@"加价");
//    }]];
//
//    [self addSubview:self.inputView];

    
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self.delegate MMInputFunctionView:self sendMessage:textView.text];
        //在这里做你响应return键的代码
        [self.textViewInput resignFirstResponder];
        self.textViewInput.text = @"";
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}



@end
