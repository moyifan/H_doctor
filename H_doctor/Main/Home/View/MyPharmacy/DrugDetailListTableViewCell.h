//
//  DrugDetailListTableViewCell.h
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugListModel.h"
@interface DrugDetailListTableViewCell : UITableViewCell

@property (nonatomic,strong) DrugList *model;

@property (nonatomic, copy) void (^AddButtonClickedBlock)(UIButton *sender);

@end
