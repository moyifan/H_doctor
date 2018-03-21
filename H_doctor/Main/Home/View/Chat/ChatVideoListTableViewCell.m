//
//  ChatVideoListTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/25.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ChatVideoListTableViewCell.h"

@implementation ChatVideoListTableViewCell
{
    UIImageView *_icon;
    QMUILabel *_name;
    QMUILabel *_source;
    QMUILabel *_timeLabel;
    QMUILabel *_time;
    
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
    _icon = [[UIImageView alloc] init];
    _icon.layer.cornerRadius = 15;
    _icon.layer.masksToBounds = YES;
    
    
    //
    _name = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(14) textColor:darkShenColor];
    
    //
    _source = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(11) textColor:darkQianColor];
    _source.text = @"来自APP";
    
    //
    _time = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:[UIColor redColor]];
    
    //
    _timeLabel = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkQianColor];
    
    // 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    
    
    NSArray *views = @[_icon,_name,_source,_time,_timeLabel,line];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    
    _icon.sd_layout.centerYEqualToView(contentView).leftSpaceToView(contentView, 13).widthIs(30).heightIs(30);
    
    _name.sd_layout.topEqualToView(_icon).leftSpaceToView(_icon, 10).heightIs(_name.font.lineHeight);
    [_name setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    _source.sd_layout.leftEqualToView(_name).topSpaceToView(_name, 5).heightIs(_source.font.lineHeight);
    [_source setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    _time.sd_layout.centerYEqualToView(contentView).rightSpaceToView(contentView, 17).heightIs(_time.font.lineHeight);
    [_time setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    _timeLabel.sd_layout.centerYEqualToView(contentView).rightSpaceToView(_time, 0).heightIs(_timeLabel.font.lineHeight);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
  
}


-(void)setModel:(ChatModel *)model
{
    _model = model;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"header_icon_line"]];

    _name.text = model.realname1;

    _time.text = [self getMMSSFromSS:[NSString stringWithFormat:@"%ld",model.seconds]];;
    
    _timeLabel.text = @"已排队时间：";


}


-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];
    
//    NSLog(@"format_time : %@",format_time);
    
    return format_time;
}


@end
