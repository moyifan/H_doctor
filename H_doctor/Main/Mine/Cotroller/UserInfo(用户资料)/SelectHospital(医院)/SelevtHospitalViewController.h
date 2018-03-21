//
//  SelevtHospitalViewController.h
//  H_doctor
//
//  Created by zhiren on 2017/12/18.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelevtHospitalViewController : UIViewController

@property (nonatomic, copy) void (^ReturnValueBlock) (NSString *strValue,NSString *ID);

@end
