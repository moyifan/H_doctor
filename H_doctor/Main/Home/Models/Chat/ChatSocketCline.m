//
//  ChatSocketCline.m
//  H_doctor
//
//  Created by zhiren on 2018/3/8.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ChatSocketCline.h"

@implementation ChatSocketCline


+(SocketIOClient *)shareSocketCline
{
    static SocketManager *manager = nil;
    static SocketIOClient *socket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // socket连接
        manager = [[SocketManager alloc] initWithSocketURL:[NSURL URLWithString:@"http://192.168.10.197:3111"] config:@{@"log": @NO, @"compress": @YES}];
        manager.reconnects = YES;
        socket = manager.defaultSocket;
        
    });
    return socket;
}



@end
