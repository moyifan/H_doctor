//
//  PrescriptionTemplateTableViewCell.h
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescriptionTemplateTableViewCell : QMUITableViewCell

@property (nonatomic ,strong) QMUIButton *edit;
@property (nonatomic ,strong) QMUIButton *delet;

@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) UILabel *content;
@property (nonatomic ,strong) UILabel *DQ;
@property (nonatomic ,strong) UILabel *detail;




@end
