//
//  Professional certification  CertificationViewController.m
//  H_doctor
//
//  Created by zhiren on 2017/12/20.
//  Copyright © 2017年 zhiren. All rights reserved.
//

#import "CertificationViewController.h"
#import "MMSheetView.h"
#import "MMPopupItem.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"


@interface CertificationViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong)UIImagePickerController *imagePickerVc; // 图片选择器

@end

@implementation CertificationViewController
{
    UIImageView *_uploadBtn;
    
}
-(void)setNavBar
{
    [self.navigationView setTitle:@"职业认证"];
    
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
    [tip setTitle:@"请您务必填写真实信息，您的信息我们会严格保密。" forState:UIControlStateNormal];
    [tip setTitleColor:darkzhongColor forState:UIControlStateNormal];
    tip.titleLabel.font = PingFangFONT(14);
    tip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tip lc_imageTitleHorizontalAlignmentWithSpace:6];
    tip.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    
    [self.view addSubview:tip];
    
    tip.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, 64).rightEqualToView(self.view).heightIs(43);
    
    
    
    UIView *card = [[UIView alloc] init];
    card.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *cardLabel = [[UILabel alloc] init];
    cardLabel.font = PingFangFONT(16);
    cardLabel.textColor = darkShenColor;
    cardLabel.text = @"职业证号";
    
    
    UITextField *cardID = [[UITextField alloc] init];
    cardID.font = PingFangFONT(16);
    cardID.textColor = darkQianColor;
    cardID.textAlignment = NSTextAlignmentRight;
    
    
    [self.view addSubview:card];
    [card addSubview:cardLabel];
    [card addSubview:cardID];
    
    
    card.sd_layout.leftEqualToView(self.view).topSpaceToView(tip, 10).rightEqualToView(self.view).heightIs(44);
    
    cardLabel.sd_layout.leftSpaceToView(card, 15).centerYEqualToView(card).heightIs(cardLabel.font.lineHeight);
    [cardLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    cardID.sd_layout.centerYEqualToView(card).rightSpaceToView(card, 18).leftSpaceToView(cardLabel, 30).heightIs(cardID.font.lineHeight);
    
    
    
    // 上传View
    
    UIView *uploadView = [[UIView alloc] init];
    uploadView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = PingFangFONT(16);
    tipLabel.textColor = darkShenColor;
    tipLabel.text = @"请上传职业证书或手持工牌照";
    
    
    UIImageView *uploadBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_unload"]];
    _uploadBtn = uploadBtn;
    [uploadBtn sizeToFit];
    UITapGestureRecognizer *IDCardFrontTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickIDCardFront:)];
    IDCardFrontTap.numberOfTapsRequired = 1;
    [uploadBtn addGestureRecognizer:IDCardFrontTap];
    
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(239, 239, 239);
    
    
    UILabel *shili = [[UILabel alloc] init];
    shili.font = PingFangFONT(16);
    shili.textColor = darkShenColor;
    shili.text = @"示例:";
    
    
    UIImageView *Sample1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demonstration_"]];
    [Sample1 sizeToFit];
    
    UIImageView *Sample2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demonstration_pic"]];
    [Sample2 sizeToFit];
    
    
    UIImageView *dottedline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dottedline"]];
    
    
    UIButton *tipfoot = [[UIButton alloc] init];
    [tipfoot setBackgroundColor:[UIColor whiteColor]];
    [tipfoot setImage:[UIImage imageNamed:@"bulb_icon"] forState:UIControlStateNormal];
    [tipfoot setTitle:@"认证之后方可开通问诊，您将得到更好的服务！" forState:UIControlStateNormal];
    [tipfoot setTitleColor:darkShenColor forState:UIControlStateNormal];
    tipfoot.titleLabel.font = PingFangFONT(14);
    tipfoot.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tipfoot lc_imageTitleHorizontalAlignmentWithSpace:6];
    tipfoot.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    
    
    [self.view addSubview:uploadView];
    [uploadView addSubview:tipLabel];
    [uploadView addSubview:uploadBtn];
    [uploadView addSubview:line];
    [uploadView addSubview:shili];
    [uploadView addSubview:Sample1];
    [uploadView addSubview:Sample2];
    [uploadView addSubview:dottedline];
    [uploadView addSubview:tipfoot];
    
    
    uploadView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(card, 10);
    
    tipLabel.sd_layout.leftSpaceToView(uploadView, 16).topSpaceToView(uploadView, 15).heightIs(tipLabel.font.lineHeight);
    [tipLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    uploadBtn.sd_layout.leftSpaceToView(uploadView, 16).topSpaceToView(tipLabel, 15).widthIs(75).heightIs(75);
    
    line.sd_layout.leftEqualToView(uploadView).rightEqualToView(uploadView).topSpaceToView(uploadBtn, 21).heightIs(1);
    
    shili.sd_layout.leftSpaceToView(uploadView, 16).topSpaceToView(line, 17).heightIs(shili.font.lineHeight);
    [shili setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    Sample1.sd_layout.leftSpaceToView(uploadView, 16).topSpaceToView(shili, 15).widthIs(75).heightIs(75);
    
    Sample2.sd_layout.topEqualToView(Sample1).leftSpaceToView(Sample1, 22).widthIs(75).heightIs(75);
    
    dottedline.sd_layout.leftSpaceToView(uploadView, 15).rightSpaceToView(uploadView, 15).topSpaceToView(Sample1, 15).heightIs(1);
    
    tipfoot.sd_layout.leftEqualToView(uploadView).topSpaceToView(dottedline, 10).rightEqualToView(uploadView).heightIs(44);

    
    [uploadView setupAutoHeightWithBottomView:tipfoot bottomMargin:0];
    
    
    
    
    // 提交
    UIButton *submit = [[UIButton alloc] init];
    [submit setBackgroundImage:[UIImage imageNamed:@"button_sub"] forState:UIControlStateNormal];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(didClickSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submit];
    
    submit.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
    
    
    
}

// 点击提交
-(void)didClickSubmit
{
    
   
}


//点击上传
-(void)didClickIDCardFront:(UITapGestureRecognizer *)sender{
    
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
    
    _uploadBtn.image = img;
    
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
    
    _uploadBtn.image = img;
    
}








@end
