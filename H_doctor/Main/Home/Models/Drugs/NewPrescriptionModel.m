//
//Created by ESJsonFormatForMac on 18/03/14.
//

#import "NewPrescriptionModel.h"
@implementation NewPrescriptionModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [PrescriptionDrugs class]};
}


@end

@implementation PrescriptionDrugs


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


