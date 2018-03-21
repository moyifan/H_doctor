//
//  ChatListTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/10.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ChatListTableViewCell.h"

@implementation ChatListTableViewCell
{
    UIImageView *_icon;
    UILabel *_name;
    UILabel *_detail;
    UILabel *_date;
    UILabel *_remainingDate;
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
    _icon.layer.cornerRadius = 18;
    _icon.layer.masksToBounds = YES;
    _icon.image = [UIImage imageNamed:@"header_icon_line"];
    
    
    //姓名
    _name = [[UILabel alloc] init];
    _name.textColor = darkShenColor;
    _name.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    _name.text = @"王晓宇";
    
    //详情
    _detail = [[UILabel alloc] init];
    _detail.textColor = darkQianColor;
    _detail.font = PingFangFONT(16);
    _detail.numberOfLines = 1;
    _detail.text = @"李医生您说的那个药在哪才能买到";
    
    //消息时间
    _date = [[UILabel alloc] init];
    _date.textColor = darkQianColor;
    _date.font = PingFangFONT(11);
    _date.text = @"下午  4:32:45";
    
    //剩余时间
    _remainingDate = [[UILabel alloc] init];
    _remainingDate.textColor = [UIColor redColor];
    _remainingDate.font = PingFangFONT(11);
    _remainingDate.text = @"28min";
    
    
    // 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    
    
    NSArray *views = @[_icon,_name,_detail,_date,_remainingDate,line];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    
    
    _icon.sd_layout.centerYEqualToView(contentView).leftSpaceToView(contentView, 15).widthIs(36).heightIs(36);
    
    _name.sd_layout.topEqualToView(_icon).leftSpaceToView(_icon, 10).heightIs(_name.font.lineHeight);
    [_name setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    _detail.sd_layout.topSpaceToView(_name, 6).leftEqualToView(_name).heightIs(_detail.font.lineHeight).widthIs(220);
   
    _date.sd_layout.bottomEqualToView(_name).rightSpaceToView(contentView, 16).heightIs(_date.font.lineHeight);
    [_date setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    

    _remainingDate.sd_layout.bottomEqualToView(_detail).rightEqualToView(_date).heightIs(_remainingDate.font.lineHeight);
    [_remainingDate setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    line.sd_layout.bottomEqualToView(contentView).leftEqualToView(contentView).rightEqualToView(contentView).heightIs(1);
    
    
}









@end
