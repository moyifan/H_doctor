//
//  AllSectionModel.h
//  H_doctor
//
//  Created by zhiren on 2018/2/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class List,Nodes;
@interface AllSectionModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<List *> *list;

@end
@interface List : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *sectionname;

@property (nonatomic, assign) NSInteger levels;

@property (nonatomic, strong) NSArray<Nodes *> *nodes;

@end

@interface Nodes : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *sectionname;

@property (nonatomic, assign) NSInteger levels;

@property (nonatomic, strong) NSArray *nodes;

@end

