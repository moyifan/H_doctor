//
//  HomeCollectionViewCell.m
//  H_doctor
//
//  Created by zhiren on 2017/12/7.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell
{
    UIImageView *_iconView;
    UILabel *_title;
    UILabel *_detail;
    
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setup];
        
    }
    return self;
}


-(void)setup
{
    _iconView = [[UIImageView alloc] init];
  
    
    _title = [[UILabel alloc] init];
    _title.textColor = darkShenColor;
    _title.font = PingFangFONT(18);
    
    
    _detail = [[UILabel alloc] init];
    _detail.textColor = darkQianColor;
    _detail.font = PingFangFONT(12);
    
    
    
    NSArray *views = @[_iconView,_title,_detail];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    _iconView.sd_layout.rightSpaceToView(contentView, 16).centerYEqualToView(contentView).widthIs(45).heightIs(45);

    
    _title.sd_layout.leftSpaceToView(contentView, 15).topEqualToView(_iconView).offset(3).heightIs(_title.font.lineHeight);
    [_title setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    
    _detail.sd_layout.topSpaceToView(_title, 6).leftSpaceToView(contentView, 16).heightIs(_detail.font.lineHeight);
    [_detail setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];

    
    
}


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        _iconView.image = [UIImage imageNamed:@"shouye_shipinjiezhen_icon"];
        _title.text = @"视频接诊";
        _detail.text = @"开启视频模式";
    }else if(indexPath.row == 1){
        _iconView.image = [UIImage imageNamed:@"shouye_tuwenjiezhen_icon"];
        _title.text = @"图文接诊";
        _detail.text = @"快速聊天模式";
    }else if(indexPath.row == 2){
        _iconView.image = [UIImage imageNamed:@"shouye_wodeyaofang_icon"];
        _title.text = @"我的药房";
        _detail.text = @"添加处方模板";
    }else{
        _iconView.image = [UIImage imageNamed:@"shouye_wodezhenfei_icon"];
        _title.text = @"我的诊费";
        _detail.text = @"查看近期收入";
    }
    
}


@end
