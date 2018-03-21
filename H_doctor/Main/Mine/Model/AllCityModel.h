//
//  AllCityModel.h
//  H_doctor
//
//  Created by zhiren on 2018/3/12.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AllCity,Citylist,Hosptllist;
@interface AllCityModel : NSObject

@property (nonatomic, strong) NSArray<AllCity *> *ds;

@end
@interface AllCity : NSObject

@property (nonatomic, copy) NSString *prov;

@property (nonatomic, strong) NSArray<Citylist *> *citylist;

@end

@interface Citylist : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<Hosptllist *> *hosptllist;

@end

@interface Hosptllist : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *hosptlname;

@end

