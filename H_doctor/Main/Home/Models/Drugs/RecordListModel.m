//
//Created by ESJsonFormatForMac on 18/03/14.
//

#import "RecordListModel.h"
@implementation RecordListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [RecordList class]};
}


@end

@implementation RecordList


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


