//
//  PrescriptionTemplateViewController.h
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeTempletModel.h"

typedef NS_ENUM(NSUInteger, PrescriptionState) {
    NewPre = 0,
    EditPre = 1,
};

@interface PrescriptionTemplateViewController : UIViewController

@property (nonatomic,copy) NSString *titleName;

@property (nonatomic,strong) RecipeTemplet *Recipetmodel;

@property (nonatomic,assign) PrescriptionState state;

@end
