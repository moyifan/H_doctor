//
//  AllCityModel.m
//  H_doctor
//
//  Created by zhiren on 2018/3/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AllCityModel.h"

@implementation AllCityModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [AllCity class]};
}


@end

@implementation AllCity

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"citylist" : [Citylist class]};
}


@end


@implementation Citylist

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"hosptllist" : [Hosptllist class]};
}


@end


@implementation Hosptllist


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end
