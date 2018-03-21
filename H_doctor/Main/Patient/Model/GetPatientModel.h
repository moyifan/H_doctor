//
//Created by ESJsonFormatForMac on 18/02/24.
//

#import <Foundation/Foundation.h>

@class Ds;
@interface GetPatientModel : NSObject

@property (nonatomic, strong) NSMutableArray<Ds *> *ds;

@end
@interface Ds : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *endtime;

@property (nonatomic, copy) NSString *realname;

@property (nonatomic, assign) NSInteger src;

@property (nonatomic, copy) NSString *addtime;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *sfzcode;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger dst;

@property (nonatomic, assign) NSInteger days;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *gender;

@end

