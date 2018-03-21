//
//  MyPharmacyTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/4.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "MyPharmacyTableViewCell.h"

@implementation MyPharmacyTableViewCell
{
    UIImageView *_icon;
    UILabel *_title;
    UILabel *_price;
    
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
    // 图片
    _icon = [[UIImageView alloc] init];
    
    
    // 药名
    _title = [[UILabel alloc] init];
    _title.font = PingFangFONT(16);
    _title.textColor = darkShenColor;
    
    
    // 价格
    _price = [[UILabel alloc] init];
    _price.font = PingFangFONT(16);
    _price.textColor = [UIColor redColor];
    
    
    // 查看详情
    _check = [[UIButton alloc] init];
    [_check setBackgroundImage:[UIImage imageNamed:@"viewthedetails"] forState:UIControlStateNormal];
    [_check sizeToFit];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineBG;
    
    
    NSArray *views = @[_icon,_title,_price,_check,line];
    [self.contentView sd_addSubviews:views];
    
    
    UIView *contentView = self.contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    
    
    
    _icon.sd_layout.leftSpaceToView(contentView, 15).topSpaceToView(contentView, 15).widthIs(75).heightIs(75);
    
    _title.sd_layout.leftSpaceToView(_icon, 20).topEqualToView(_icon).rightSpaceToView(contentView, 20).autoHeightRatio(0);
    
    _price.sd_layout.leftEqualToView(_title).bottomEqualToView(_icon).heightIs(_price.font.lineHeight);
    [_price setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _check.sd_layout.bottomEqualToView(_icon).rightSpaceToView(contentView, 16).widthIs(_check.width).heightIs(_check.height);
    
    
    line.sd_layout.leftEqualToView(_icon).rightEqualToView(contentView).heightIs(1).topSpaceToView(_icon, 15);
    
    
    
    [self setupAutoHeightWithBottomView:line bottomMargin:0];
    
    
    
}


-(void)setModel:(Drugs *)model
{
    _model = model;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"drug_pic"]];

    _title.text = model.medcname;

    _price.text = [NSString stringWithFormat:@"¥%.2f",model.price];

    
}






@end
