//
//  AllSectionModel.m
//  H_doctor
//
//  Created by zhiren on 2018/2/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AllSectionModel.h"

@implementation AllSectionModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [List class]};
}


@end

@implementation List

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"nodes" : [Nodes class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation Nodes


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



