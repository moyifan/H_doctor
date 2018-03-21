//
//  PrescriptionTemplateTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/5.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "PrescriptionTemplateTableViewCell.h"

@implementation PrescriptionTemplateTableViewCell
{
    UIView *_backView;
//    UILabel *_title;
//    UILabel *_content;
//    UILabel *_DQ;
//    UILabel *_detail;

    
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


-(void)setup
{
    // 背景view
    _backView = [[UIView alloc] init];
    _backView.layer.cornerRadius = 3;
    _backView.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f] CGColor];
    _backView.layer.borderWidth = 1;
    _backView.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    _backView.alpha = 1;
    
    
    // btnView
    UIButton *btnView = [[UIButton alloc] init];
    [btnView setBackgroundImage:[UIImage imageNamed:@"yuanjiao_icon"] forState:UIControlStateNormal];

    
    //
    _edit = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"edit_icon"] title:nil];
    [_edit sizeToFit];
    
    _delet = [[QMUIButton alloc] qmui_initWithImage:[UIImage imageNamed:@"delete_icon_"] title:nil];
    [_delet sizeToFit];

    
    
    //药名
    _title = [[UILabel alloc] init];
    _title.font = PingFangFONT(15);
    _title.textColor = darkShenColor;
//    _title.text = @"阿莫西林胶囊";
    
    
    //用量
    _content = [[UILabel alloc] init];
    _content.font = PingFangFONT(14);
    _content.textColor = darkzhongColor;
//    _content.text = @"sig:口服 用量:2.5mg";
    
    //dq
    _DQ = [[UILabel alloc] init];
    _DQ.font = PingFangFONT(14);
    _DQ.textColor = darkzhongColor;
//    _DQ.text = @"QID 共30天";
    
    //嘱托
    _detail = [[UILabel alloc] init];
    _detail.font = PingFangFONT(14);
    _detail.textColor = darkzhongColor;
//    _detail.text = @"请于饭后一小时服用";
    
    
    
    [self.contentView addSubview:_backView];
    [_backView addSubview:btnView];
    [btnView addSubview:_edit];
    [btnView addSubview:_delet];
    
    
    _backView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topEqualToView(self.contentView);
    
    btnView.sd_layout.topEqualToView(_backView).rightEqualToView(_backView).widthIs(56).heightRatioToView(_backView, 1);
    
    
    _edit.sd_layout.centerXEqualToView(btnView).topSpaceToView(btnView, 17).widthIs(_edit.width).heightIs(_edit.height);
    
     _delet.sd_layout.centerXEqualToView(btnView).bottomSpaceToView(btnView, 17).widthIs(_delet.width).heightIs(_delet.height);
    
    
    
    [_backView addSubview:_title];
    [_backView addSubview:_content];
    [_backView addSubview:_DQ];
    [_backView addSubview:_detail];

    
    _title.sd_layout.leftSpaceToView(_backView, 10).topSpaceToView(_backView, 15).rightSpaceToView(_backView, 10).autoHeightRatio(0);
    
    _content.sd_layout.leftSpaceToView(_backView, 10).topSpaceToView(_title, 10).rightSpaceToView(_backView, 10).autoHeightRatio(0);
    
    _DQ.sd_layout.leftSpaceToView(_backView, 10).topSpaceToView(_content, 10).rightSpaceToView(_backView, 10).autoHeightRatio(0);
    
    _detail.sd_layout.leftSpaceToView(_backView, 10).topSpaceToView(_DQ, 10).rightSpaceToView(_backView, 10).autoHeightRatio(0);
    
    
    [_backView setupAutoHeightWithBottomView:_detail bottomMargin:15];
    
    [self setupAutoHeightWithBottomView:_backView bottomMargin:10];
    
}






@end
