//
//  MyPharmacyTableViewCell.h
//  H_doctor
//
//  Created by zhiren on 2018/1/4.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugsModel.h"

@interface MyPharmacyTableViewCell : QMUITableViewCell

@property (nonatomic, strong) UIButton *check;

@property (nonatomic, strong) Drugs *model;

@end
