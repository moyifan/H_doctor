//
//Created by ESJsonFormatForMac on 18/03/13.
//

#import "DrugsModel.h"
@implementation DrugsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [Drugs class]};
}


@end

@implementation Drugs


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


