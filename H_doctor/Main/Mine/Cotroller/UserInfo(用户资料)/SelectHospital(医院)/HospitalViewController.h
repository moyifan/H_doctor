//
//  HospitalViewController.h
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AllCityModel.h"

typedef NS_ENUM(NSUInteger, HospitalState) {
    title = 0,
    hos = 1,
};



@interface HospitalViewController : UIViewController

@property (nonatomic,assign) HospitalState hospitalState;

@property (nonatomic, copy) void (^ReturnValueBlock) (NSString *strValue);

@property (nonatomic,strong) NSArray<Hosptllist *> *hosModel;

@property (nonatomic, copy) void (^ReturnHosValueBlock) (NSString *strValue, NSString *ID);

@end
