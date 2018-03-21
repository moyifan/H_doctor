//
//  MMChatInputView.h
//  H_doctor
//
//  Created by zhiren on 2018/3/8.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMChatInputView;

@protocol MMChatInputViewDelegate <NSObject>

// text
- (void)MMInputFunctionView:(MMChatInputView *)funcView sendMessage:(NSString *)message;


@end


@interface MMChatInputView : UIView

@property (nonatomic, retain) UITextView *textViewInput;

@property (nonatomic, assign) id<MMChatInputViewDelegate>delegate;

@end
