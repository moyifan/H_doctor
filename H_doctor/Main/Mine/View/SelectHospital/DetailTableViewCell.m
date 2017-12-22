//
//  DetailTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
{
    UILabel *_content;
    UILabel *_detail;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = RGB(235, 235, 238);
        
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
    _content.text = @"神农架滑雪";
    
    
    _detail = [[UILabel alloc] init];
    _detail.font = PingFangFONT(16);
    _detail.textColor = darkShenColor;
    _detail.text = @"12";
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(221, 221, 221);
    
    
    [self.contentView addSubview:_content];
    [self.contentView addSubview:_detail];
    [self.contentView addSubview:line];

    
    
    _content.sd_layout.leftSpaceToView(self.contentView, 16).centerYEqualToView(self.contentView).heightIs(_content.font.lineHeight);
    [_content setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _detail.sd_layout.rightSpaceToView(self.contentView, 16).centerYEqualToView(self.contentView).heightIs(_detail.font.lineHeight);
    [_detail setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    line.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView).heightIs(1);

    
}


@end
