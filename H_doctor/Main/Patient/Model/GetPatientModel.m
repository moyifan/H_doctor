//
//Created by ESJsonFormatForMac on 18/02/24.
//

#import "GetPatientModel.h"
@implementation GetPatientModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [Ds class]};
}


@end

@implementation Ds


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


