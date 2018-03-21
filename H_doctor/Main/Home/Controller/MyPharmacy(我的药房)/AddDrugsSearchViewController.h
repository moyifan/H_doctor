//
//  AddDrugsSearchViewController.h
//  H_doctor
//
//  Created by zhiren on 2018/1/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AddDrugsSearchState) {
    NewAdd = 0,
    EditAdd = 1,
};

@interface AddDrugsSearchViewController : UIViewController

@property (nonatomic,assign) AddDrugsSearchState state;

@property (nonatomic ,copy) NSString *templetId;

@end
