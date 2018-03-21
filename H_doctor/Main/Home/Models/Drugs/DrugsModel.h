//
//Created by ESJsonFormatForMac on 18/03/13.
//

#import <Foundation/Foundation.h>

@class Drugs;
@interface DrugsModel : NSObject

@property (nonatomic, strong) NSMutableArray<Drugs *> *ds;

@end
@interface Drugs : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *factoryname;

@property (nonatomic, copy) NSString *zhuzhi;

@property (nonatomic, assign) NSInteger medcid;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *usage;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *medcname;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *chengfen;

@property (nonatomic, copy) NSString *wenhao;

@property (nonatomic, copy) NSString *spec;

@property (nonatomic, copy) NSString *attention;

@end

