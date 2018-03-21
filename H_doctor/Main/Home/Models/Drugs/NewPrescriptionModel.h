//
//Created by ESJsonFormatForMac on 18/03/14.
//

#import <Foundation/Foundation.h>

@class PrescriptionDrugs;
@interface NewPrescriptionModel : NSObject

@property (nonatomic, strong) NSArray<PrescriptionDrugs *> *ds;

@end
@interface PrescriptionDrugs : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *yongfa;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger medcid;

@property (nonatomic, copy) NSString *usage;

@property (nonatomic, copy) NSString *medcname;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *pinci;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) CGFloat yongliang;

@property (nonatomic, assign) NSInteger days;

@property (nonatomic, copy) NSString *yizhu;

@property (nonatomic, copy) NSString *spec;

@end

