//
//Created by ESJsonFormatForMac on 18/02/23.
//

#import <Foundation/Foundation.h>

@class TagList;
@interface AllTagModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<TagList *> *list;

@end
@interface TagList : NSObject

@property (nonatomic, copy) NSString *tagname;

@end

