//
//  UserInfoViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/15.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "UserInfoViewController.h"
#import "WRCellView.h"
#import "MMSheetView.h"
#import "MMPopupItem.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "ShuruViewController.h"
#import "SelevtHospitalViewController.h"
#import "SelectOfficeViewController.h"
#import "SelectTitleViewController.h"
#import "BeGoodViewController.h"

#import "Helper.h"

//网络
#import "YTKBatchRequest.h"
#import "UpdateUserIcon.h"
#import "UpdateTagService.h"
#import "UpdateSectionService.h"
#import "UpdateExpertiseService.h"
#import "UpdateRealNameService.h"
#import "UpdateHospitalService.h"
#import "UpdateGenderService.h"


@interface UserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) WRCellView *iconView;
@property (nonatomic, strong) WRCellView *realNameView;
@property (nonatomic, strong) WRCellView *sexView;
@property (nonatomic, strong) WRCellView *phoneView;

@property (nonatomic, strong) WRCellView *certificateView;
@property (nonatomic, strong) WRCellView *hospitalView;
@property (nonatomic, strong) WRCellView *officeView;
@property (nonatomic, strong) WRCellView *TitleView;
@property (nonatomic, strong) WRCellView *beGoodView;

@property (nonatomic, strong)UIImagePickerController *imagePickerVc; // 图片选择器

@property (nonatomic, assign) NSInteger officeID;
@property (nonatomic, copy) NSString *hospitalID;


@end

@implementation UserInfoViewController

-(void)setNavBar
{
    [self.navigationView setTitle:@"基本资料"];
    
    MPWeakSelf(self)
 //   [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
   //     [weakself.navigationController popViewControllerAnimated:YES];
   // }];
    
    [self.navigationView addRightButtonWithTitle:@"提交" clickCallBack:^(UIView *view) {
       
        [weakself updateUserInfo];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(242, 246, 250);
    
    [self setNavBar];
    
    
    [self setupSubviews];
    [self onClickEvent];
    
    
}



-(void)setupSubviews
{
    
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.realNameView];
    [self.view addSubview:self.sexView];
    [self.view addSubview:self.phoneView];
    
    [self.view addSubview:self.certificateView];
    [self.view addSubview:self.hospitalView];
    [self.view addSubview:self.officeView];
    [self.view addSubview:self.TitleView];
    [self.view addSubview:self.beGoodView];

    
    
    _iconView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).heightIs(AdaptedWidth(68));
    
    _realNameView.sd_layout.leftSpaceToView(self.view, 0).rightEqualToView(self.view).topSpaceToView(_iconView, 0).heightIs(AdaptedWidth(44));
    
    _sexView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_realNameView, 0).heightIs(AdaptedWidth(44));
    
    _phoneView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_sexView, 0).heightIs(AdaptedWidth(44));
    
    
    
    _certificateView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_phoneView, 10).heightIs(AdaptedWidth(44));
    
    _hospitalView.sd_layout.leftSpaceToView(self.view, 0).rightEqualToView(self.view).topSpaceToView(_certificateView, 0).heightIs(AdaptedWidth(44));
    
    _officeView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_hospitalView, 0).heightIs(AdaptedWidth(44));
    
    _TitleView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_officeView, 0).heightIs(AdaptedWidth(44));
    
    _beGoodView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_TitleView, 0).heightIs(AdaptedWidth(44));

    
}


- (void)onClickEvent
{
    __weak typeof(self) weakSelf = self;
    self.iconView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis selectCamera];
    };
    self.realNameView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        ShuruViewController *shu = [[ShuruViewController alloc] init];
        shu.titleShu = @"真实姓名";
        [pThis.navigationController pushViewController:shu animated:YES];
        
        if (!shu.backClickedBlock) {
            [shu setBackClickedBlock:^(NSString *content) {
                
                pThis.realNameView.rightLabel.text = content;
                [pThis.realNameView layoutSubviews];
                
            }];
        }
        
    };
    
    self.sexView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis selectSex];
    };
    
    self.phoneView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        ShuruViewController *shu = [[ShuruViewController alloc] init];
        shu.title = @"手机号";
        [pThis.navigationController pushViewController:shu animated:YES];

        if (!shu.backClickedBlock) {
            [shu setBackClickedBlock:^(NSString *content) {

                pThis.phoneView.rightLabel.text = content;
                [pThis.phoneView layoutSubviews];

            }];
        }
        
    };
    
    self.certificateView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        ShuruViewController *shu = [[ShuruViewController alloc] init];
        shu.title = @"证书编号";
        [pThis.navigationController pushViewController:shu animated:YES];
        
        if (!shu.backClickedBlock) {
            [shu setBackClickedBlock:^(NSString *content) {
                
                pThis.certificateView.rightLabel.text = content;
                [pThis.certificateView layoutSubviews];
                
            }];
        }
    };
    
    self.hospitalView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        SelevtHospitalViewController *shu = [[SelevtHospitalViewController alloc] init];
        [pThis.navigationController pushViewController:shu animated:YES];
        shu.ReturnValueBlock = ^(NSString *str,NSString *ID){
            pThis.hospitalView.rightLabel.text = str;
            [pThis.hospitalView layoutSubviews];
            pThis.hospitalID = ID;
        };
    };
    
    self.officeView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        SelectOfficeViewController *shu = [[SelectOfficeViewController alloc] init];
        [pThis.navigationController pushViewController:shu animated:YES];
        shu.ReturnValueBlock = ^(NSString *str,NSInteger ID){
            pThis.officeView.rightLabel.text = str;
            [pThis.officeView layoutSubviews];
            pThis.officeID = ID;
        };
    };
    
    self.TitleView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        SelectTitleViewController *shu = [[SelectTitleViewController alloc] init];
        [pThis.navigationController pushViewController:shu animated:YES];
        shu.ReturnValueBlock = ^(NSString *str){
            pThis.TitleView.rightLabel.text = str;
            [pThis.TitleView layoutSubviews];
        };
    };
    
    self.beGoodView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        BeGoodViewController *shu = [[BeGoodViewController alloc] init];
        [pThis.navigationController pushViewController:shu animated:YES];
        if (!shu.backClickedBlock) {
            [shu setBackClickedBlock:^(NSString *content) {
                
                pThis.beGoodView.rightLabel.text = content;
                [pThis.beGoodView layoutSubviews];
                
            }];
        }
    };
    
    
}

// 相机
-(void)selectCamera
{
    
    MMPopupItemHandler block = ^(NSInteger index){
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        self.imagePickerVc = imagePicker;
        imagePicker.delegate= self;
        
        switch (index) {
            case 0:
                if (![Helper checkCameraAuthorizationStatus]) {
                    return;
                }
                [self takePhoto];
                break;
            case 1:
                if (![Helper checkPhotoLibraryAuthorizationStatus]) {
                    return;
                }
                [self pushImagePickerController];
                break;
                
            default:
                break;
        }
    };
    
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
        //        NSLog(@"animation complete");
    };
    
    NSArray *items =
    @[MMItemMake(@"拍摄", MMItemTypeNormal, block),
      MMItemMake(@"相册", MMItemTypeNormal, block)];
    
    
    [MMSheetViewConfig globalConfig].itemNormalColor = RGB(0, 157, 217);
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@""
                                                          items:items];
    sheetView.type = MMPopupTypeSheet;
    sheetView.attachedView = self.view;
    sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    [sheetView showWithBlock:completeBlock];
    
}


// 相机
- (void)takePhoto {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        self.imagePickerVc.allowsEditing = YES;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    }
    
}

#pragma mark 图片代理方法
// 点击取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.iconView.rightIcon.image = img;
    [self.iconView layoutSubviews];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


// 相册
- (void)pushImagePickerController {
    
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;  // 圆形裁剪框
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}



// 从相册选择图片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    UIImage *img = photos[0];
    
    self.iconView.rightIcon.image = img;
    [self.iconView layoutSubviews];
    
}







// 选择性别
-(void)selectSex
{
    
    MMPopupItemHandler block = ^(NSInteger index){
        
        switch (index) {
            case 0:
                self.sexView.rightLabel.text = @"男";
                break;
            case 1:
                self.sexView.rightLabel.text = @"女";
                break;
                
            default:
                break;
        }
        [self.sexView layoutSubviews];

    };
    
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
        //        NSLog(@"animation complete");
    };
    
    NSArray *items =
    @[MMItemMake(@"男", MMItemTypeNormal, block),
      MMItemMake(@"女", MMItemTypeNormal, block)];
    
    
//    [MMSheetViewConfig globalConfig].itemNormalColor = RGB(0, 157, 217);
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@""
                                                          items:items];
    sheetView.type = MMPopupTypeSheet;
    sheetView.attachedView = self.view;
    sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    [sheetView showWithBlock:completeBlock];
    
}







#pragma mark 懒加载

-(WRCellView *)iconView
{
    if (!_iconView) {
        
        _iconView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_IconLabelIndicator];
        _iconView.leftLabel.text = @"头像";
        _iconView.rightIcon.layer.cornerRadius = 25;
        _iconView.rightIcon.layer.masksToBounds = YES;
        [_iconView.rightIcon sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareUserInfo].model.doc.img] placeholderImage:[UIImage imageNamed:@"yishengtouxiang_icon"]];

        
    }
    
    return _iconView;
}

-(WRCellView *)realNameView
{
    if (!_realNameView) {
        
        _realNameView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _realNameView.leftLabel.text = @"姓名";
        _realNameView.rightLabel.text = [UserInfo shareUserInfo].model.doc.realname;
    }
    
    return _realNameView;
}


-(WRCellView *)sexView
{
    if (!_sexView) {
        
        _sexView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _sexView.leftLabel.text = @"性别";
        _sexView.rightLabel.text = [UserInfo shareUserInfo].model.doc.gender;
    }
    
    return _sexView;
}

-(WRCellView *)phoneView
{
    if (!_phoneView) {
        
        _phoneView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _phoneView.leftLabel.text = @"手机号";
        _phoneView.rightLabel.text = [UserInfo shareUserInfo].model.doc.tel;
        _phoneView.userInteractionEnabled = NO;
        [_phoneView setLineStyleWithLeftZero];

    }
    
    return _phoneView;
}


-(WRCellView *)certificateView
{
    if (!_certificateView) {
        
        _certificateView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _certificateView.userInteractionEnabled = NO;
        _certificateView.leftLabel.text = @"证书编号";
        _certificateView.rightLabel.text = [UserInfo shareUserInfo].model.doc.certcode;
        
    }
    
    return _certificateView;
}

-(WRCellView *)hospitalView
{
    if (!_hospitalView) {
        
        _hospitalView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _hospitalView.leftLabel.text = @"所在医院";
        _hospitalView.rightLabel.text = [UserInfo shareUserInfo].model.doc.govname;
        _hospitalID = [NSString stringWithFormat:@"%ld",[UserInfo shareUserInfo].model.doc.hospitalid];
    }
    
    return _hospitalView;
}

-(WRCellView *)officeView
{
    if (!_officeView) {
        
        _officeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _officeView.leftLabel.text = @"所在科室";
        _officeView.rightLabel.text = [UserInfo shareUserInfo].model.doc.sectionname;
        _officeID = [UserInfo shareUserInfo].model.doc.sectionid;
        
    }
    
    return _officeView;
}


-(WRCellView *)TitleView
{
    if (!_TitleView) {
        
        _TitleView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _TitleView.leftLabel.text = @"职称";
        _TitleView.rightLabel.text = [UserInfo shareUserInfo].model.doc.title;
        
    }
    
    return _TitleView;
}

-(WRCellView *)beGoodView
{
    if (!_beGoodView) {
        
        _beGoodView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _beGoodView.leftLabel.text = @"擅长";
        _beGoodView.rightLabel.text = [UserInfo shareUserInfo].model.doc.expertise;
        
    }
    
    return _beGoodView;
}




#pragma mark 网络

-(void)updateUserInfo
{
    [MBProgressHUD showLoadToView:nil];

    NSMutableArray *requestArray = [NSMutableArray array];
    

    UpdateUserIcon *updateIcon = [[UpdateUserIcon alloc] initWithDocid:DoctorUserDefault.ID Img:self.iconView.rightIcon.image];
    
    UpdateRealNameService *updateName = [[UpdateRealNameService alloc] initWithDocid:DoctorUserDefault.ID realname:self.realNameView.rightLabel.text];
    
    UpdateTagService *updateTag = [[UpdateTagService alloc] initWithDocid:DoctorUserDefault.ID tagname:self.TitleView.rightLabel.text];
  
    UpdateSectionService *updateSection = [[UpdateSectionService alloc] initWithDocid:DoctorUserDefault.ID sectionid:[NSString stringWithFormat:@"%ld",self.officeID]];
    
    UpdateHospitalService *updateHospital = [[UpdateHospitalService alloc] initWithDocid:DoctorUserDefault.ID hosptlid:self.hospitalID];
    
    NSString *sex;
    if ([self.sexView.rightLabel.text isEqualToString:@"男"]) {
        sex = @"1";
    }else{
        sex = @"2";
    }
    
    UpdateGenderService *updateGender = [[UpdateGenderService alloc] initWithDocid:DoctorUserDefault.ID gender:sex];
    
    
    UpdateExpertiseService *updateExpertise = [[UpdateExpertiseService alloc] initWithDocid:DoctorUserDefault.ID expertise:self.beGoodView.rightLabel.text];
    
    
    [requestArray addObject:updateIcon];
    [requestArray addObject:updateName];
    [requestArray addObject:updateTag];
    [requestArray addObject:updateSection];
    [requestArray addObject:updateExpertise];
    [requestArray addObject:updateHospital];
    [requestArray addObject:updateGender];
    

    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:requestArray];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
//        NSLog(@"success %@ ",batchRequest.requestArray);

        [[UserInfo shareUserInfo] updateUserInfo];
        [MBProgressHUD hideHUD];
        [self.navigationController popViewControllerAnimated:YES];


    } failure:^(YTKBatchRequest *batchRequest) {
        NSLog(@"faile %@ ",batchRequest.failedRequest);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络错误" ToView:nil];

    }];
    
    
}





@end

