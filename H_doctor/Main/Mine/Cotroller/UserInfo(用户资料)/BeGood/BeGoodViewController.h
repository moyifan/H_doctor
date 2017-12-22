//
//  BeGoodViewController.h
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeGoodViewController : UIViewController
@property (nonatomic, copy) void (^backClickedBlock)(NSString *content);

@end
