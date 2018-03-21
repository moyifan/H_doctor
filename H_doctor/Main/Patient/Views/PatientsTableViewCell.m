//
//  PatientsTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/10.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "PatientsTableViewCell.h"

@implementation PatientsTableViewCell
{
    UIImageView *_icon;
    UILabel *_name;
    UILabel *_info;
    UILabel *_date;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


-(void)setup
{
    
    // 头像
    _icon = [[UIImageView alloc] init];
    _icon.layer.cornerRadius = 22.5;
    _icon.layer.masksToBounds = YES;
    
    
    //姓名
    _name = [[UILabel alloc] init];
    _name.textColor = darkShenColor;
    _name.font = PingFangFONT(16);
    
    //详情
    _info = [[UILabel alloc] init];
    _info.textColor = darkzhongColor;
    _info.font = PingFangFONT(14);
    
    //消息时间
    _date = [[UILabel alloc] init];
    _date.textColor = [UIColor redColor];
    _date.font = PingFangFONT(16);
    
    
    
    // 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    
    
    NSArray *views = @[_icon,_name,_info,_date,line];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    
    
    _icon.sd_layout.centerYEqualToView(contentView).leftSpaceToView(contentView, 15).widthIs(45).heightIs(45);
    
    _name.sd_layout.centerYEqualToView(contentView).leftSpaceToView(_icon, 15).heightIs(_name.font.lineHeight);
    [_name setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    _info.sd_layout.centerYEqualToView(contentView).leftSpaceToView(_name,30).heightIs(_info.font.lineHeight);
    [_info setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];

    
    _date.sd_layout.centerYEqualToView(contentView).rightSpaceToView(contentView, 16).heightIs(_date.font.lineHeight);
    [_date setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];

    line.sd_layout.bottomEqualToView(contentView).leftEqualToView(contentView).rightEqualToView(contentView).heightIs(1);
    
    
}


-(void)setModel:(Ds *)model
{
    _model = model;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"header_icon_line"]];

    _name.text = model.realname;

    _info.text = [NSString stringWithFormat:@"%@ %ld岁",model.gender,model.age];

    _date.text = [NSString stringWithFormat:@"%ld天",model.days];

    
}


@end
