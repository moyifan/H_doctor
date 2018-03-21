//
//  AddDrugsDetailViewController.h
//  H_doctor
//
//  Created by zhiren on 2018/1/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugsModel.h"
#import "NewPrescriptionModel.h"

typedef NS_ENUM(NSUInteger, SaveState) {
    NewSave = 0,
    UpdateSave = 1,
};

typedef NS_ENUM(NSUInteger, EditSaveState) {
    EditNewSave = 0,
    EditUpdateSave = 1,
};


@interface AddDrugsDetailViewController : UIViewController

//@property (nonatomic ,strong) Drugs *model;

@property (nonatomic ,copy) NSString *templetId;

@property (nonatomic ,strong) PrescriptionDrugs *model;

@property (nonatomic ,assign) SaveState saveState;

@property (nonatomic ,assign) EditSaveState editSaveState;

@property (nonatomic ,assign) BOOL isEdit;

@end
