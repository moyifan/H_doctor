//
//Created by ESJsonFormatForMac on 18/03/14.
//

#import "DrugListModel.h"
@implementation DrugListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [DrugList class]};
}


@end

@implementation DrugList


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


