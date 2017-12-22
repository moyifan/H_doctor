//
//  IncomeManageTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2017/12/21.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "IncomeManageTableViewCell.h"

@implementation IncomeManageTableViewCell
{
    UIImageView *_icon;
    UILabel *_content;
    UIImageView *_allow;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setup];
        
    }
    return self;
}


-(void)setup
{
    
    _icon = [[UIImageView alloc] init];
    
    
    // 内容
    _content = [[UILabel alloc] init];
    _content.font = PingFangFONT(16);
    _content.textColor = darkShenColor;
    
    
    _allow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gengduo_icon"]];
    [_allow sizeToFit];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(239, 239, 239);
    
    
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_content];
    [self.contentView addSubview:_allow];
    [self.contentView addSubview:line];
    
    
    
    _icon.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, 16).widthIs(21).heightIs(22);
    
    
    _content.sd_layout.leftSpaceToView(_icon, 16).centerYEqualToView(self.contentView).heightIs(_content.font.lineHeight);
    [_content setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _allow.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 28).widthIs(_allow.width).heightIs(_allow.height);
    
    line.sd_layout.leftEqualToView(_content).rightEqualToView(_allow).bottomEqualToView(self.contentView).heightIs(1);
    
}



-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    if (indexPath.row == 0) {
        _icon.image = [UIImage imageNamed:@"income_icon"];
        _content.text = @"总收入：36973.30";
        _allow.hidden = YES;
    }else if (indexPath.row == 1){
        _icon.image = [UIImage imageNamed:@"withdrawals_icon"];
        _content.text = @"提现记录";
        _allow.hidden = NO;
    }else{
        _icon.image = [UIImage imageNamed:@"income_detail_icon"];
        _content.text = @"诊费收入明细";
        _allow.hidden = NO;

    }
    

    
    
}








@end
