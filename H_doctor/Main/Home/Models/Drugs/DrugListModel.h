//
//Created by ESJsonFormatForMac on 18/03/14.
//

#import <Foundation/Foundation.h>

@class DrugList;
@interface DrugListModel : NSObject

@property (nonatomic, strong) NSMutableArray<DrugList *> *ds;

@end
@interface DrugList : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *factoryname;

@property (nonatomic, copy) NSString *zhuzhi;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *usage;

@property (nonatomic, assign) BOOL has;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *medcname;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *chengfen;

@property (nonatomic, copy) NSString *wenhao;

@property (nonatomic, copy) NSString *spec;

@property (nonatomic, copy) NSString *attention;

@end

