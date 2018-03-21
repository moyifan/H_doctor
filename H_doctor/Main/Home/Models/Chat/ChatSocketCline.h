//
//  ChatSocketCline.h
//  H_doctor
//
//  Created by zhiren on 2018/3/8.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatSocketCline : NSObject

@property (strong, nonatomic) SocketManager *manager;
@property (strong, nonatomic) SocketIOClient *socket;

+(SocketIOClient *)shareSocketCline;

@end
