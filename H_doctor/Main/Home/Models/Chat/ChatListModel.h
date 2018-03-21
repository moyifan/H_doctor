//
//  ChatListModel.h
//  H_doctor
//
//  Created by zhiren on 2018/3/1.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatModel;
@interface ChatListModel : NSObject

@property (nonatomic, strong) NSArray<ChatModel *> *ds;

@end
@interface ChatModel : NSObject

@property (nonatomic, assign) NSInteger caseid;

@property (nonatomic, copy) NSString *addtime;

@property (nonatomic, copy) NSString *realname1;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger dstid;

@property (nonatomic, copy) NSString *realname;

@property (nonatomic, assign) NSInteger seconds;

@property (nonatomic, assign) NSInteger srcid;

@end
