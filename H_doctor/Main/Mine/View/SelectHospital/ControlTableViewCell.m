//
//  ControlTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "ControlTableViewCell.h"

@implementation ControlTableViewCell
{
    UILabel *_content;
}
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
    _content.font = PingFangFONT(16);
    _content.textColor = darkShenColor;
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(221, 221, 221);
    
    
    [self.contentView addSubview:_content];
    [self.contentView addSubview:line];

    
    _content.sd_layout.leftSpaceToView(self.contentView, 16).centerYEqualToView(self.contentView).heightIs(_content.font.lineHeight);
    [_content setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    line.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView).heightIs(1);
    
}






@end
