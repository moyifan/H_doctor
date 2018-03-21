//
//  ReceptionTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/18.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "ReceptionTableViewCell.h"

@implementation ReceptionTableViewCell
{
    QMUILabel *_timeSlotA;
    QMUILabel *_timeSlotB;
    QMUILabel *_timeSlotC;
    QMUILabel *_timeSlotD;
  
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = AllBG;
    }
    return self;
}


-(void)setup
{
    
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];
    
    _fewWeeks = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    
    
    _timeSlotA = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    _timeSlotA.text = @"/";
    _timeSlotA.textAlignment = NSTextAlignmentCenter;

    _timeSlotB = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    _timeSlotB.text = @"/";
    _timeSlotB.textAlignment = NSTextAlignmentCenter;

    _timeSlotC = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    _timeSlotC.text = @"/";
    _timeSlotC.textAlignment = NSTextAlignmentCenter;

    _timeSlotD = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    _timeSlotD.text = @"/";
    _timeSlotD.textAlignment = NSTextAlignmentCenter;
    
    
    UIImageView *more = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gengduo_icon"]];
    [more sizeToFit];
    

    [self.contentView addSubview:back];
    [back addSubview:_fewWeeks];
    [back addSubview:_timeSlotA];
    [back addSubview:_timeSlotB];
    [back addSubview:_timeSlotC];
    [back addSubview:_timeSlotD];
    [back addSubview:more];
    
    back.sd_layout.leftEqualToView(self.contentView).topEqualToView(self.contentView).rightEqualToView(self.contentView).bottomSpaceToView(self.contentView, 5);
    
    
    _fewWeeks.sd_layout.centerYEqualToView(back).leftSpaceToView(back, 15).heightIs(_fewWeeks.font.lineHeight);
    [_fewWeeks setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _timeSlotA.sd_layout.leftSpaceToView(_fewWeeks, 50).topSpaceToView(back, 10).heightIs(_timeSlotA.font.lineHeight).widthIs(100);
    
    _timeSlotB.sd_layout.leftSpaceToView(_timeSlotA, 25).topSpaceToView(back, 10).heightIs(_timeSlotB.font.lineHeight).widthIs(100);

    _timeSlotC.sd_layout.leftSpaceToView(_fewWeeks, 50).bottomSpaceToView(back, 10).heightIs(_timeSlotC.font.lineHeight).widthIs(100);

    _timeSlotD.sd_layout.leftSpaceToView(_timeSlotC, 25).bottomSpaceToView(back, 10).heightIs(_timeSlotD.font.lineHeight).widthIs(100);

    
    more.sd_layout.rightSpaceToView(back, 15).centerYEqualToView(back).widthIs(more.width).heightIs(more.height);
    
    
}



-(void)setDic:(NSArray *)dic
{
    _dic = dic;

    if (dic.count == 0) {
        return;
    }
    if (dic.count >= 1) {
        _timeSlotA.text = [NSString stringWithFormat:@"%@~%@",dic[0][@"starttime"],dic[0][@"endtime"]];
    }
    if (dic.count >= 2){
        _timeSlotB.text = [NSString stringWithFormat:@"%@~%@",dic[1][@"starttime"],dic[1][@"endtime"]];

    }
    if (dic.count >= 3){
        _timeSlotC.text = [NSString stringWithFormat:@"%@~%@",dic[2][@"starttime"],dic[2][@"endtime"]];
        
    }
    if (dic.count >= 4){
        _timeSlotD.text = [NSString stringWithFormat:@"%@~%@",dic[3][@"starttime"],dic[3][@"endtime"]];
        
    }
    
    
}






@end
