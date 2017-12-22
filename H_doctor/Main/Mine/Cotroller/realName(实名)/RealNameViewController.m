//
//  RealNameViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/14.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "RealNameViewController.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "MMSheetView.h"
#import "MMPopupItem.h"
#import "RealNamePresentController.h"


@interface RealNameViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong)UIImagePickerController *imagePickerVc; // 图片选择器
@property (nonatomic, assign)BOOL isIDCardFront; // 图片选择器

@end

@implementation RealNameViewController
{
    UIImageView *_IDCardFront;
    UIImageView *_IDCardBack;

}

-(void)setNavBar
{
    [self.navigationView setTitle:@"实名认证"];
    
    MPWeakSelf(self)
    [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back_"] clickCallBack:^(UIView *view) {
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGB(242, 246, 250);
    
    [self setNavBar];
    
    [self setupSubViews];
}



-(void)setupSubViews
{
    UIButton *tip = [[UIButton alloc] init];
    [tip setBackgroundColor:[UIColor whiteColor]];
    [tip setImage:[UIImage imageNamed:@"zhuyi_icon"] forState:UIControlStateNormal];
    [tip setTitle:@"您提交的资料将仅用于实名认证审核" forState:UIControlStateNormal];
    [tip setTitleColor:darkzhongColor forState:UIControlStateNormal];
    tip.titleLabel.font = PingFangFONT(14);
    tip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tip lc_imageTitleHorizontalAlignmentWithSpace:6];
    tip.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

    
    [self.view addSubview:tip];
    
    tip.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, 64).rightEqualToView(self.view).heightIs(43);
    
    
    
    //
    UIView *IDCardView = [[UIView alloc] init];
    IDCardView.backgroundColor = [UIColor whiteColor];
    
    
    // 身份证正面
    _IDCardFront = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhengmian_icon"]];
    [_IDCardFront sizeToFit];
    _IDCardFront.userInteractionEnabled = YES;
    UITapGestureRecognizer *IDCardFrontTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickIDCardFront:)];
    IDCardFrontTap.numberOfTapsRequired = 1;
    [_IDCardFront addGestureRecognizer:IDCardFrontTap];
    


    
    _IDCardBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fanmian_icon"]];
    [_IDCardBack sizeToFit];
    _IDCardBack.userInteractionEnabled = YES;
    UITapGestureRecognizer *IDCardBackTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickIDCardBack:)];
    IDCardBackTap.numberOfTapsRequired = 1;
    [_IDCardBack addGestureRecognizer:IDCardBackTap];
    
    

    [self.view addSubview:IDCardView];
    [IDCardView addSubview:_IDCardFront];
    [IDCardView addSubview:_IDCardBack];

    
    IDCardView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(tip, 10);
    
    _IDCardFront.sd_layout.centerXEqualToView(IDCardView).topSpaceToView(IDCardView, 15).widthIs(_IDCardFront.width).heightIs(_IDCardFront.height);
    
    _IDCardBack.sd_layout.centerXEqualToView(IDCardView).topSpaceToView(_IDCardFront, 15).widthIs(_IDCardBack.width).heightIs(_IDCardBack.height);
    
    [IDCardView setupAutoHeightWithBottomView:_IDCardBack bottomMargin:15];
    
    
    
    // 提交
    UIButton *submit = [[UIButton alloc] init];
    [submit setBackgroundImage:[UIImage imageNamed:@"button_sub"] forState:UIControlStateNormal];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(didClickSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submit];
    
    submit.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
    
    
}


-(void)didClickSubmit
{
    RealNamePresentController *present = [[RealNamePresentController alloc] init];
    EasyNavigationController *nav = [[EasyNavigationController alloc] initWithRootViewController:present];

    [self presentViewController:nav animated:YES completion:^{
        
    }];
}




//点击正面
-(void)didClickIDCardFront:(UITapGestureRecognizer *)sender{

    self.isIDCardFront = YES;
    [self selectCamera];

}


// 点击背面
-(void)didClickIDCardBack:(UITapGestureRecognizer *)sender{
    
    self.isIDCardFront = NO;
    [self selectCamera];
}


-(void)selectCamera
{

    MMPopupItemHandler block = ^(NSInteger index){

        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        self.imagePickerVc = imagePicker;
        imagePicker.delegate= self;
        
        switch (index) {
            case 0:
                [self takePhoto];
                break;
            case 1:
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
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
//            self.imagePickerVc.allowsEditing = YES;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        }
        
        
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
    
    if (self.isIDCardFront) {
        _IDCardFront.image = img;
    }else{
        _IDCardBack.image = img;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


// 相册
- (void)pushImagePickerController {
    
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    //    imagePickerVc.allowPickingOriginalPhoto = YES;

    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}



// 从相册选择图片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    UIImage *img = photos[0];
    
    if (self.isIDCardFront) {
        _IDCardFront.image = img;
    }else{
        _IDCardBack.image = img;
    }
    
}








@end
