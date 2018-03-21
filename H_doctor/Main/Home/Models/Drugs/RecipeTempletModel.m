//
//Created by ESJsonFormatForMac on 18/03/16.
//

#import "RecipeTempletModel.h"
@implementation RecipeTempletModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ds" : [RecipeTemplet class]};
}


@end

@implementation RecipeTemplet

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"detail" : [RecipeTempletDetail class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation RecipeTempletDetail


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


