//
//  PrescribePrescriptionTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/25.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "PrescribePrescriptionTableViewCell.h"

@implementation PrescribePrescriptionTableViewCell
{
    

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
    _title = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkQianColor];
    
    _detail = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    
    //
    _edit = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"edit_icon"] title:nil];
    [_edit sizeToFit];
  
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    
   
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_detail];
    [self.contentView addSubview:_edit];
    [self.contentView addSubview:line];
    
    
    _title.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, 15).heightIs(_title.font.lineHeight);
    [_title setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _detail.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(_title, 0).heightIs(_detail.font.lineHeight);
    [_detail setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _edit.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView).widthIs(_edit.width).heightIs(_edit.height);

    
    line.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView).heightIs(1);

}





@end
