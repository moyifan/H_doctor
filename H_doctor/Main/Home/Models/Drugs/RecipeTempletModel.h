//
//Created by ESJsonFormatForMac on 18/03/16.
//

#import <Foundation/Foundation.h>

@class RecipeTemplet,RecipeTempletDetail;
@interface RecipeTempletModel : NSObject

@property (nonatomic, strong) NSArray<RecipeTemplet *> *ds;

@end
@interface RecipeTemplet : NSObject

@property (nonatomic, assign) BOOL can_edit_del;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<RecipeTempletDetail *> *detail;

@property (nonatomic, assign) NSInteger sicknessid;

@property (nonatomic, copy) NSString *sicknessname;

@property (nonatomic, copy) NSString *title_diy;

@end

@interface RecipeTempletDetail : NSObject

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

