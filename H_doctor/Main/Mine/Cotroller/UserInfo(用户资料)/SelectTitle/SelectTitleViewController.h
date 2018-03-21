//
//  SelectTitleViewController.h
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTitleViewController : UIViewController

@property (nonatomic, copy) void (^ReturnValueBlock) (NSString *strValue);

@end
