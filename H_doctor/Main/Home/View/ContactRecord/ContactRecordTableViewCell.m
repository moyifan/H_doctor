//
//  ContactRecordTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/8.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ContactRecordTableViewCell.h"

@implementation ContactRecordTableViewCell

{
    UILabel *_type;
    UILabel *_name;
    UILabel *_data;
    UILabel *_state;
    UILabel *_result;
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
    // 接诊模式
    _type = [[UILabel alloc] init];
    _type.font = [UIFont fontWithName:@"PingFang SC-Bold" size:35.0f];;
    _type.textColor = darkShenColor;
    
    
    // 姓名
    _name = [[UILabel alloc] init];
    _name.font = PingFangFONT(16);
    _name.textColor = darkzhongColor;
    
    
    // 个人信息
    _data = [[UILabel alloc] init];
    _data.font = PingFangFONT(14);
    _data.textColor = darkQianColor;
    
    
    // 进行状态
    _state = [[UILabel alloc] init];
    _state.font = PingFangFONT(16);
    _state.textColor = RGB(72,147,245);
    
    
    // 处方结果
    _result = [[UILabel alloc] init];
    _result.font = PingFangFONT(16);
    _result.textColor = darkzhongColor;
    
    
    // 时间
    _date = [[UILabel alloc] init];
    _date.font = PingFangFONT(14);
    _date.textColor = darkQianColor;
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    
    
    NSArray *views = @[_type,_name,_data,_state,_result,_date,line];
    [self.contentView sd_addSubviews:views];
    
    
    UIView *contentView = self.contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    
    
    
    _type.sd_layout.leftSpaceToView(contentView, 15).topSpaceToView(contentView, 15).heightIs(_type.font.lineHeight);
    [_type setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _name.sd_layout.leftEqualToView(_type).topSpaceToView(_type, 15).heightIs(_name.font.lineHeight);
    [_name setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _data.sd_layout.leftEqualToView(_name).topSpaceToView(_name, 10).heightIs(_data.font.lineHeight);
    [_data setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _state.sd_layout.centerYEqualToView(_type).rightSpaceToView(contentView, 15).heightIs(_state.font.lineHeight);
    [_state setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _result.sd_layout.topSpaceToView(_state, 15).rightEqualToView(_state).heightIs(_result.font.lineHeight);
    [_result setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _date.sd_layout.topSpaceToView(_result, 15).rightEqualToView(_result).heightIs(_date.font.lineHeight);
    [_date setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    line.sd_layout.leftEqualToView(contentView).rightEqualToView(contentView).heightIs(1).topSpaceToView(_data, 16);
    
    
    
    [self setupAutoHeightWithBottomView:line bottomMargin:0];
    
    
    
    
}



-(void)setModel:(RecordList *)model
{
    _model = model;
    
    
    
    _type.text = model.typename;

    _name.text = model.dstname;

    _data.text = [NSString stringWithFormat:@"%@   %@",model.dstgender,model.dsttel];

    _state.text = model.statusname;

    _result.text = model.chufangname;

    _date.text = model.starttime;

    
}





@end
