//
//  SelectCityViewController.h
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AllCityModel.h"

typedef NS_ENUM(NSUInteger, CityState) {
    office = 0,
    city = 1,
};


@interface SelectCityViewController : UIViewController

@property (nonatomic,assign) CityState cityState; // 问诊类型

@property (nonatomic, copy) void (^ReturnValueBlock) (NSString *strValue, NSInteger strID);

@property (nonatomic, copy) void (^ReturnHosValueBlock) (NSArray<Hosptllist *> *cityList);

@end
