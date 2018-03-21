//
//  ChatListModel.m
//  H_doctor
//
//  Created by zhiren on 2018/3/1.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ChatListModel.h"

@implementation ChatListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [ChatModel class]};
}


@end

@implementation ChatModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end
