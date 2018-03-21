//
//  DrugsDetailTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "DrugsDetailTableViewCell.h"

@implementation DrugsDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = RGB(239, 239, 241);
        
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
    _content.text = @"抗生素";
    _content.highlightedTextColor = RGB(45,183,245);

    
    _detail = [[UILabel alloc] init];
    _detail.font = PingFangFONT(13);
    _detail.textColor = darkShenColor;
    _detail.text = @"12";
    _detail.highlightedTextColor = RGB(45,183,245);

    
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
