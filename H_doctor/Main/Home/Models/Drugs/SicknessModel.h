//
//Created by ESJsonFormatForMac on 18/03/16.
//

#import <Foundation/Foundation.h>

@class Sickness;
@interface SicknessModel : NSObject

@property (nonatomic, strong) NSArray<Sickness *> *ds;

@end
@interface Sickness : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *sicknessname;

@end

