//
//  DiagnosisViewController.h
//  H_doctor
//
//  Created by zhiren on 2018/1/19.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DiagnosisState) {
    Moban = 0,
    Chufang = 1,
};

@interface DiagnosisViewController : UIViewController

@property (nonatomic,assign) DiagnosisState state;

@property (nonatomic, copy) void (^ReturnValueBlock) (NSMutableArray *array,NSMutableArray *IDarray,NSString *custom);

@end
