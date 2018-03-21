//
//  TemplateTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/16.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "TemplateTableViewCell.h"

@implementation TemplateTableViewCell

{
    QMUILabel *_title;
    QMUILabel *_detail;
    
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
    _title = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(16) textColor:darkShenColor];
    _title.numberOfLines = 1;
    
    
    _detail = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(13) textColor:darkzhongColor];
    _detail.numberOfLines = 1;

    //
    _edit = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"edit_icon"] title:nil];
    [_edit sizeToFit];
    
    _delet = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"delete_icon_"] title:nil];
    [_delet sizeToFit];
    
    
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_detail];
    [self.contentView addSubview:_edit];
    [self.contentView addSubview:_delet];

    
    _title.sd_layout.leftSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView).heightIs(_title.font.lineHeight).widthIs(120);
    
    _detail.sd_layout.leftSpaceToView(_title, 24).centerYEqualToView(self.contentView).heightIs(_detail.font.lineHeight).widthIs(70);
    
    _delet.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView).widthIs(_delet.width).heightIs(_delet.height);
    
    _edit.sd_layout.rightSpaceToView(_delet, 15).centerYEqualToView(self.contentView).widthIs(_edit.width).heightIs(_edit.height);

    
}


-(void)setModel:(RecipeTemplet *)model
{
    _model = model;
    
    _title.text = model.title;

    _detail.text = model.sicknessname;
    
    if (model.can_edit_del == NO) {
        _edit.hidden = YES;
        _delet.hidden = YES;
    }else{
        _edit.hidden = NO;
        _delet.hidden = NO;
    }

}



@end
