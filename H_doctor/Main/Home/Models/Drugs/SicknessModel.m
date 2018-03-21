//
//Created by ESJsonFormatForMac on 18/03/16.
//

#import "SicknessModel.h"
@implementation SicknessModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [Sickness class]};
}


@end

@implementation Sickness


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


