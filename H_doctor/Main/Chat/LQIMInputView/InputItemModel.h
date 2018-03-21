//
//  InputItemModel.h
//  LQIMInputView
//
//  Created by lawchat on 2016/10/25.
//  Copyright © 2016年 674297026@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InputItemModel : NSObject

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *imageName;

typedef void (^ItemClicked)(void);
@property(nonatomic, copy) ItemClicked clickedBlock;


+ (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName clickedBlock:(ItemClicked)clickedBlock;

@end
