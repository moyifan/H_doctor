//
//  MyFeesTableViewCell.m
//  H_doctor
//
//  Created by zhiren on 2018/1/15.
//  Copyright © 2018年 zhiren. All rights reserved.
//

#import "MyFeesTableViewCell.h"

#define Multiple Main_Screen_Width/375

@implementation MyFeesTableViewCell
{
    QMUILabel *_name;
    QMUILabel *_sex;
    QMUILabel *_price;
    QMUILabel *_state;
    
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
    
    _name = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(15) textColor:darkShenColor];
    _name.text = @"王晓晓";
    _name.textAlignment = NSTextAlignmentCenter;
    
    _sex = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(15) textColor:darkShenColor];
    _sex.text = @"女";
    _sex.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:0.7f];
    _sex.textAlignment = NSTextAlignmentCenter;

    
    _price = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(15) textColor:darkShenColor];
    _price.text = @"120.00元";
    _price.textAlignment = NSTextAlignmentCenter;

    
    _state = [[QMUILabel alloc] qmui_initWithFont:PingFangFONT(15) textColor:darkShenColor];
    _state.text = @"已开处方";
    _state.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:0.7f];
    _state.textAlignment = NSTextAlignmentCenter;

    
    [self.contentView addSubview:_name];
    [self.contentView addSubview:_sex];
    [self.contentView addSubview:_price];
    [self.contentView addSubview:_state];

    _name.sd_layout.leftEqualToView(self.contentView).topEqualToView(self.contentView).bottomEqualToView(self.contentView).widthIs(86*Multiple);
    
    _sex.sd_layout.leftSpaceToView(_name, 0).topEqualToView(self.contentView).bottomEqualToView(self.contentView).widthIs(71*Multiple);

    _price.sd_layout.leftSpaceToView(_sex, 0).topEqualToView(self.contentView).bottomEqualToView(self.contentView).widthIs(119*Multiple);

    _state.sd_layout.leftSpaceToView(_price, 0).topEqualToView(self.contentView).bottomEqualToView(self.contentView).rightEqualToView(self.contentView);
    
    
}


@end
