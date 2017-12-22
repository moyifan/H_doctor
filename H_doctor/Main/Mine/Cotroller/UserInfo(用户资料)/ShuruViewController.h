//
//  ShuruViewController.h
//  hospital
//
//  Created by zhiren on 2017/7/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "BaseViewController.h"

@interface ShuruViewController : UIViewController

@property (nonatomic,copy) NSString *titleShu;

@property (nonatomic, copy) void (^backClickedBlock)(NSString *content);

@end
