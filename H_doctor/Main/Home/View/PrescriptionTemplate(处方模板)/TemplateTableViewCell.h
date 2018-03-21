//
//  TemplateTableViewCell.h
//  H_doctor
//
//  Created by zhiren on 2018/1/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecipeTempletModel.h"
@interface TemplateTableViewCell : QMUITableViewCell

@property (nonatomic,strong) QMUIButton *edit;
@property (nonatomic,strong) QMUIButton *delet;

@property (nonatomic,strong) RecipeTemplet *model;

@end

