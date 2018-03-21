//
//  PrescribePrescriptionTableViewCell.h
//  H_doctor
//
//  Created by zhiren on 2018/1/25.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface PrescribePrescriptionTableViewCell : QMUITableViewCell
@property (nonatomic,strong) QMUIButton *edit;
@property (nonatomic,strong) QMUILabel *title;
@property (nonatomic,strong) QMUILabel *detail;

@end
