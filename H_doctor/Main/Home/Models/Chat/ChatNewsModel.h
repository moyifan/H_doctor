//
//  ChatNewsModel.h
//  H_doctor
//
//  Created by zhiren on 2018/3/2.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UUMessageFrame;

@interface ChatNewsModel : NSObject

@property (nonatomic, strong) NSMutableArray<UUMessageFrame *> *dataSource;


- (void)populateRandomDataSource;

- (void)addRandomItemsToDataSource:(NSInteger)number;

- (void)addSpecifiedItem:(NSDictionary *)dic;

- (void)recountFrame;


@end
