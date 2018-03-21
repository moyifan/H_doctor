//
//  AddCommonDrugsTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "AddCommonDrugsTableViewCell.h"

@implementation AddCommonDrugsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setup];
        
    }
    return self;
}


-(void)setup
{
    // 内容
    _content = [[UILabel alloc] init];
    _content.font = PingFangFONT(13);
    _content.textColor = darkShenColor;
    _content.text = @"感冒药";
    _content.highlightedTextColor = RGB(45,183,245);
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(221, 221, 221);
    
    
    [self.contentView addSubview:_content];
    [self.contentView addSubview:line];
    
    
    _content.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).heightIs(_content.font.lineHeight);
    [_content setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    line.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView).heightIs(1);
    
    
   
    
}






@end
