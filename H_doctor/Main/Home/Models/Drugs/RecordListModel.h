//
//Created by ESJsonFormatForMac on 18/03/14.
//

#import <Foundation/Foundation.h>

@class RecordList;
@interface RecordListModel : NSObject

@property (nonatomic, strong) NSArray<RecordList *> *ds;

@end
@interface RecordList : NSObject

@property (nonatomic, copy) NSString *typename;

@property (nonatomic, copy) NSString *dsttel;

@property (nonatomic, copy) NSString *starttime;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *statusname;

@property (nonatomic, copy) NSString *dstname;

@property (nonatomic, copy) NSString *dstgender;

@property (nonatomic, copy) NSString *chufangname;

@end

