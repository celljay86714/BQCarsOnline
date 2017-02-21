//
//  VKPhotoPicker.m
//  VKProprietorAssistant
//
//  Created by wolfire on 9/14/15.
//  Copyright (c) 2015 Jay. All rights reserved.
//

#import "VKPhotoPicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>

#import "UIView+OnePixelLine.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

#import "VKCategory.h"
#import "TZImageManager.h"
//#import "OtherRequestManager.h"

typedef NS_ENUM(NSUInteger, CapturePhotoType) {
    CapturePhotoTypeCamera,
    CapturePhotoTypeLibrary
};

@interface VKPhotoPicker () <
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (strong, nonatomic, readwrite) NSMutableArray <UIImage *> *pickedImages;
@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property (strong, nonatomic) NSMutableArray *imageButtons;
// @property (strong, nonatomic) VKImageHandler *imageHandler;
@property (strong, nonatomic) UIScrollView *contentScrollView;

@property (assign, nonatomic) CGFloat imageWidth;

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) id externObjectR;


@end

@implementation VKPhotoPicker

- (id)initWithFrame:(CGRect)frame photoPickerDelegate:(UIViewController<VKPhotoPickerDelegate> *)delegate {
    self = [super initWithFrame:frame];

    if (self) {
        self.delegate = delegate;
        [self configerViewModel];
        [self reset];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configerViewModel];
        [self reset];
    }
    return self;
}

- (void)configerViewModel{
    self.viewModel = [[PhotoPickerModel alloc] init];
    
    @weakify(self);
    [RACObserve(self, viewModel.pickedImages) subscribeNext:^(NSMutableArray *value) {
        @strongify(self);
        self.imageUploadState = [self.viewModel checkAllImageUploadState];
        if (self.imageUploadState == ImageUploadStateFailed) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败"
                                                            message:@"有图片上传失败，是否重新上传"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            [alert uxy_handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
                if (btnIndex == 1) {
                    [self uploadAllImage];
                } else if (btnIndex == 0) {
                    [SVProgressHUD dismiss];
                }
            }];
            [alert show];
            
        }
    }];
    
    
}

- (void)reset {
    [self initVariables];
    self.backgroundColor = [UIColor clearColor];
    [self layoutAllButtons];
    self.layer.masksToBounds = YES;
    [self addLineLocationUp:YES locationDown:YES color:nil leftSpace:0 rightSpace:0];
}

- (void)initVariables {
    _imageWidth = kImageWidth;
    self.maxCount = 5;
    self.pickedImages = [NSMutableArray array];
    self.selectedAssets = [NSMutableArray array];
    self.imageButtons = [NSMutableArray array];
    self.isSpecialForAvatar = NO;
}

- (void)setPointY:(CGFloat)pointY {
    _pointY = pointY;
    [self layoutAllButtons];
}

- (void)layoutAllButtons {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    __block CGFloat positionX = kImageX;
    __block CGFloat positionY = _pointY;
    [_imageButtons removeAllObjects];
    
    if (self.pickedImages.count >= 3) {
        self.mj_h = 2*kImageWidth + IMAGE_GAP;
    } else {
        self.mj_h = kImageWidth;
    }
    
    @weakify(self)
    [self.viewModel.pickedImages enumerateObjectsUsingBlock:^(NSDictionary *imagedic, NSUInteger index, BOOL *stop) {
        @strongify(self)
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(positionX, positionY, kImageWidth, kImageWidth)];
        imageView.tag = index;
        imageView.image =[self mainContentImage:imagedic[@"image"]];
        [imageView uxy_roundedRectWith:4.0];
        // 暂时不用
        /*
         if ([[imagedic objectForKey:@"status"] isEqualToNumber:@0]) {
         UIImage *image=[UIImage imageNamed:@"icon_pic_loading"];
         UIImageView *layer = [[UIImageView alloc]initWithFrame:imageView.bounds];
         layer.image = image;
         [imageView addSubview:layer];
         } else if ([[imagedic objectForKey:@"status"] isEqualToNumber:@2]) {
         UIImage *image =[UIImage imageNamed:@"icon_pic_loading_failed"];
         UIImageView *layer = [[UIImageView alloc]initWithFrame:imageView.bounds];
         layer.image = image;
         [imageView addSubview:layer];
         
         }
         */
        if (index/2) {
            positionX = kImageX+(kImageWidth + IMAGE_GAP) * (index%2);
            positionY = kImageWidth+IMAGE_GAP+_pointY;
        } else {
            positionX = (kImageWidth + IMAGE_GAP) * (index%3 + 1)+IMAGE_GAP;
            
            positionY = _pointY;
        }
        [self addSubview:imageView];
        [_imageButtons addObject:imageView];
        
        imageView.userInteractionEnabled = YES;
        [imageView uxy_addTapGestureWithBlock:^(UIView *view) {
            [self previewImageWithTag:view.tag];
        }];
        
        /*
         UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(position - DELETE_WIDTH - 2, 1, DELETE_WIDTH, DELETE_WIDTH)];
         deleteButton.tag = index;
         [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
         [deleteButton setImage:[UIImage imageNamed:@"icon_pic_delete"] forState:UIControlStateNormal];
         [deleteButton setImage:[UIImage imageNamed:@"icon_pic_delete"] forState:UIControlStateHighlighted];
         [self.contentScrollView addSubview:deleteButton];
         self.contentScrollView.contentSize= CGSizeMake(imageView.frame.origin.x+_imageWidth, 0);
         */
    }];
    
    // 添加图片的按钮
    if (self.pickedImages.count < _maxCount) {
        
        UIButton *captureButton = [[UIButton alloc] initWithFrame:CGRectMake(positionX, positionY, kImageWidth, kImageWidth)];
        [captureButton addTarget:self action:@selector(pickImage:) forControlEvents:UIControlEventTouchUpInside];
        [captureButton setImage:[UIImage imageNamed:@"addpic_big_normal_85"] forState:UIControlStateNormal];
        [captureButton setImage:[UIImage imageNamed:@"addpic_big_pressed_85"] forState:UIControlStateHighlighted];
        [self addSubview:captureButton];
    }
}

- (UIImage *)mainContentImage:(UIImage *)image {
    CGFloat sideLength = MIN(image.size.width, image.size.height);
    CGRect rect = CGRectMake(image.size.width / 2 - sideLength / 2, image.size.height / 2 - sideLength / 2, sideLength, sideLength);
    return [self cropImage:image WithRect:rect];
}

- (UIImage *)cropImage:(UIImage *)image WithRect:(CGRect)rect {
    if (image.scale > 1.0f) {
        rect = CGRectMake(rect.origin.x * image.scale, rect.origin.y * image.scale, rect.size.width * image.scale, rect.size.height * image.scale);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

#pragma mark 操作完图片的处理
- (void)didFinishSelectedImages:(NSArray *)imagesArray assets:(NSArray *)assetsArray{

    self.pickedImages = [NSMutableArray arrayWithArray:imagesArray];
    self.selectedAssets = [NSMutableArray arrayWithArray:assetsArray];
    [self.viewModel.pickedImages removeAllObjects];
    [imagesArray enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * stop) {
        
        [self.viewModel prepareImageParamsWithImage:image];
    }];
    [self layoutAllButtons];
}

#pragma mark 上传所选的图片
- (void)uploadAllImage {
    
    [self.viewModel.pickedImages enumerateObjectsUsingBlock:^(NSDictionary *imagedic, NSUInteger index, BOOL *stop) {
        
        if (![imagedic[@"status"] isEqualToNumber:@1]) {
//            [[OtherRequestManager sharedManager] uploadFilesToQiniuCDN:^{
//                [self.viewModel uploadFileWithImageDic:imagedic];
//            }];
        }
    }];
}

#pragma mark - Actions
- (void)pickImage:(UIButton *)sender {
    if (_isSpecialForAvatar) {
        if (_pickedImages.count > sender.tag) {
            [_pickedImages removeObjectAtIndex:sender.tag];
        }
    }
    [SHAREDAPPLICATION.keyWindow endEditing:YES];
    _externObjectR = @(_pickedImages.count);
    // 弹出选择框
    [self showActionSheet];
}

// 图片右上角的删除按钮事件  暂时不需要做
- (void)deleteImage:(UIButton *)sender {

    [self.viewModel removeImageAtIndex:sender.tag];
    
    if ([_delegate respondsToSelector:@selector(photoPicker:didDeleteImageAtIndex:)]) {
        [_delegate photoPicker:self didDeleteImageAtIndex:sender.tag];
    }
}

- (void)showActionSheet {
    if (_actionSheet == nil) {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照", @"从相册选取", nil];
        
    }
    [_actionSheet showInView:[SHAREDAPPLICATION.windows objectAtIndex:0]];
}

#pragma mark - ***************  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            // 照相机拍照
            [self takePhoto];
            break;
            
        case 1: {
            // 相册选择图片
            [self gotoImagePick];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ***************  UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

- (void)takePhoto {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc = [[UIImagePickerController alloc] init];
            _imagePickerVc.sourceType = sourceType;
            _imagePickerVc.delegate = self;

            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self.delegate presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
//            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"功能受限"
                                                            message:@"当前设备不支持此功能"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }
    
//    [self pushSourceCameraControllerWithActionBlock:^{
//        
//        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//        self.imagePicker = [[UIImagePickerController alloc] init];
//        _imagePicker.delegate = self;
//        _imagePicker.sourceType = sourceType;
//        
//        [self.delegate presentViewController:_imagePicker animated:YES completion:nil];
//    }];
}

#pragma mark 选择图片
- (void)gotoImagePick {
    
    if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self gotoImagePick];
        });
    } else {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount columnNumber:3 delegate:nil];
        
        imagePickerVc.barItemTextColor = VKDefaultYellow;
        
        
        //#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
        imagePickerVc.isSelectOriginalPhoto = YES;
        
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
        imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
        
        // 2. Set the appearance
        // 2. 在这里设置imagePickerVc的外观
        // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
        // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
        // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
        
        // 3. Set allow picking video & photo & originalPhoto or not
        // 3. 设置是否可以选择视频/图片/原图
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        
        // 4. 照片排列按修改时间升序
        imagePickerVc.sortAscendingByModificationDate = YES;
        //#pragma mark - 到这里为止
        
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            [self didFinishSelectedImages:photos assets:assets];
            
            
        }];
        [self.delegate presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark 预览图片
- (void)previewImageWithTag:(NSInteger)tag {
    TZImagePickerController *browserVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_pickedImages index:tag];
    browserVc.maxImagesCount = self.maxCount;
    browserVc.allowPickingOriginalPhoto = YES;
    browserVc.isSelectOriginalPhoto = YES;
    @weakify(self)
    [browserVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @strongify(self)
        //_isSelectOriginalPhoto = isSelectOriginalPhoto;
        [self didFinishSelectedImages:photos assets:assets];
    }];
    [[self uxy_currentViewController] presentViewController:browserVc animated:YES completion:nil];

}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
// - (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
// NSLog(@"cancel");
// }

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [self didFinishSelectedImages:photos assets:assets];

    //_isSelectOriginalPhoto = isSelectOriginalPhoto;
    // [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    [self didFinishSelectedImages:@[coverImage] assets:@[asset]];

    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    //[_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}



#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    __block UIImage *aImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    
    if (aImage == nil) {
        aImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (aImage == nil) {
        aImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    }
    if (aImage == nil) {
        aImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[info objectForKey:UIImagePickerControllerReferenceURL]]];
    }
    if (aImage == nil) {
        ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
        [assetLibrary assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
                      resultBlock:^(ALAsset *asset) {
                          aImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                      }
                     failureBlock:^(NSError *error) {
                         DDLogInfo(@"Cannot get Image from ALAssetsLibrary because of [%@]", [error localizedDescription]);
                     }];
    }
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
        // tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
        [tzImagePickerVc showProgressHUD];
//        UIImage *aImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[TZImageManager manager] savePhotoWithImage:aImage completion:^(NSError *error){
            [picker dismissViewControllerAnimated:YES completion:nil];

            if (error) { // 如果保存失败，基本是没有相册权限导致的...
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法保存图片" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                alert.tag = 1;
                [alert show];
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self.selectedAssets addObject:assetModel.asset];
                        [self.pickedImages addObject:aImage];
                       
                        [self didFinishSelectedImages:self.pickedImages assets:self.selectedAssets];

                    }];
                }];
            }
        }];
//    }
}



@end

#pragma mark - ***************
#pragma mark - *************** PhotoPickerModel
@interface PhotoPickerModel()

//@property (nonatomic, strong) QNUploadManager *upManager;

@end

@implementation PhotoPickerModel

- (instancetype)init {
    if (self = [super init]) {
        _pickedImages= [NSMutableArray arrayWithCapacity:10];
//        _upManager = [[QNUploadManager alloc] init];
    }
    
    return self;
}

- (void)removeImageAtIndex:(NSInteger)index{
    if (self.pickedImages.count > index) {
        [self willChangeValueForKey:@"pickedImages"];
        [self.pickedImages removeObjectAtIndex:index];
        [self didChangeValueForKey:@"pickedImages"];
    }
}

#pragma mark 配置图片上传参数
- (void)prepareImageParamsWithImage:(UIImage *)image {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd/HH/mm:ss:ms"];
    NSDate *date = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:date];
    //    DDLogDebug(@"dateStr %@\n %@", dateStr, date);
    NSUInteger imageCount = self.pickedImages.count;
//    NSString *imageKey = [NSString stringWithFormat:@"%@%@.jpg", [dateStr substringToIndex:14], [[NSString stringWithFormat:@"%@%ld%lu", dateStr, (long)[VKUser sharedUser].userId,(unsigned long)imageCount] uxy_MD5String]];

//临时变量需要修改
    NSString *imageKey =@"";
    
    UIImage *cacheimage=[self imageCompressForSize:image targetSize:CGSizeMake(1280, 1280)];
    
    NSData  *imageData = UIImageJPEGRepresentation(cacheimage, 0.6);
    
    DDLogInfo(@"PNG %fMB 原图大小 %fMB -- 上传图片大小 %fMB", UIImagePNGRepresentation(image).length/1024.00/1024,UIImageJPEGRepresentation(image, 1.0).length/1024.00/1024,imageData.length/1024.00/1024);
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                   @"image":[UIImage imageWithData:imageData],
                                                                                   @"status":@0,
                                                                                   @"url":@"",
                                                                                   @"key":imageKey,
                                                                                   @"imageData":imageData,
                                                                                   }];
    
    [self willChangeValueForKey:@"pickedImages"];
    
    [self.pickedImages addObject:dataDic];
    
    [self didChangeValueForKey:@"pickedImages"];
}

#pragma mark 上传文件
- (void)uploadFileWithImageDic:(NSDictionary *)imageDic {
//    __block NSDictionary *qiniuMessage = [[NSUserDefaults standardUserDefaults] objectForKey:QiNiuMessage];
//    
//    QNUploadOption *option = [[QNUploadOption alloc] initWithMime:@"image/jpeg"
//                                                  progressHandler:nil
//                                                           params:@{@"bucket":qiniuMessage[@"bucket"]}
//                                                         checkCrc:YES
//                                               cancellationSignal:nil];
//    
//    [self.upManager putData:imageDic[@"imageData"]
//                        key:imageDic[@"key"]
//                      token:qiniuMessage[@"upload_token"]
//                   complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                       
//                       [self.pickedImages enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL *stop) {
//                           
//                           if ([obj[@"key"] isEqualToString:key]) {
//                               [self willChangeValueForKey:@"pickedImages"];
//                               if (resp) {
//                                   [obj setValue:resp[@"key"] forKey:@"url"];
//                                   [obj setValue:@1 forKey:@"status"];
//                                   DDLogInfo(@"图片上传成功 %@",resp);
//                               } else {
//                                   [obj setValue:@2 forKey:@"status"];
//                                   DDLogError(@"图片上传失败 %@",resp);
//                                   
//                               }
//                               
//                               [self didChangeValueForKey:@"pickedImages"];
//                           }
//                       }];
//                   } option:option];
//    
}


/**
 *  @author Vanke, 15-11-18 10:11:33
 *
 *  0 正在上传
 1 上传成功
 2 上传失败
 *
 */

- (void)addImageData:(UIImage *)image atIndex:(NSInteger)index {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd/HH/mm:ss:ms"];
    NSDate *date = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:date];
    //    DDLogDebug(@"dateStr %@\n %@", dateStr, date);
    NSUInteger imageCount = self.pickedImages.count;
//    NSString *imageKey = [NSString stringWithFormat:@"%@%@.jpg", [dateStr substringToIndex:14], [[NSString stringWithFormat:@"%@%ld%lu", dateStr, (long)[VKUser sharedUser].userId,(unsigned long)imageCount] uxy_MD5String]];
    //需要修复我
    NSString *imageKey = @"";
    
    UIImage *cacheimage=[self imageCompressForSize:image targetSize:CGSizeMake(1280, 1280)];
    
    NSData  *imageData = UIImageJPEGRepresentation(cacheimage, 0.6);
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:@{@"image":[UIImage imageWithData:imageData], @"status":@0, @"url":@"", @"key":imageKey}];
    
    [self willChangeValueForKey:@"pickedImages"];
    
    [self.pickedImages addObject:dataDic];
    
    [self didChangeValueForKey:@"pickedImages"];
    
    __block NSDictionary *qiniuMessage = [[NSUserDefaults standardUserDefaults] objectForKey:QiNiuMessage];
    
    
    //    DDLogInfo(@"%ld --- %@",(long)index,image);
    
//    QNUploadOption *option = [[QNUploadOption alloc] initWithMime:@"image/jpeg"
//                                                  progressHandler:nil
//                                                           params:@{@"bucket":qiniuMessage[@"bucket"]}
//                                                         checkCrc:YES
//                                               cancellationSignal:nil];
//    
//    [self.upManager putData:imageData
//                        key:imageKey
//                      token:qiniuMessage[@"upload_token"]
//                   complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                       
//                       [self.pickedImages enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL *stop) {
//                           
//                           if ([obj[@"key"] isEqualToString:key]) {
//                               [self willChangeValueForKey:@"pickedImages"];
//                               if (resp) {
//                                   [obj setValue:resp[@"key"] forKey:@"url"];
//                                   [obj setValue:@1 forKey:@"status"];
//                                   DDLogInfo(@"图片上传成功 %@",resp);
//                               } else {
//                                   [obj setValue:@2 forKey:@"status"];
//                                   DDLogError(@"图片上传失败 %@",resp);
//                                   
//                               }
//                               
//                               [self didChangeValueForKey:@"pickedImages"];
//                           }
//                       }];
//                   } option:option];
}

- (ImageUploadState)checkAllImageUploadState {
    __block ImageUploadState state = ImageUploadStateNotBegin;
    
    [self.pickedImages enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"status"] isEqualToNumber:@(ImageUploadStateSuccess)]) {
            state = ImageUploadStateSuccess;
        } else if ([obj[@"status"] isEqualToNumber:@(ImageUploadStateFailed)]) {
            state = ImageUploadStateFailed;
            *stop = YES;
        } else {
            state = ImageUploadStateNotBegin;
            *stop = YES;
        }
    }];
    
    return state;
}

- (NSString *)allImageRequestSting {
    NSMutableString *imageString = [NSMutableString stringWithCapacity:10];
    [self.pickedImages enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [imageString appendString:[NSString stringWithFormat:@"%@,", obj[@"url"]]];
    }];

    if (imageString.length <= 0) {
        return @"";
    }

    if ([[imageString substringWithRange:NSMakeRange(imageString.length - 1, 1)] isEqualToString:@","]) {
        [imageString deleteCharactersInRange:NSMakeRange(imageString.length - 1, 1)];
    }
    
    return imageString;
}

-(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = sourceImage;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO && height>targetHeight && width>targetWidth){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor < heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
        UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
        
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = CGPointMake(0, 0);
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        if(newImage == nil){
            DDLogInfo(@"scale image fail");
        }
        
        UIGraphicsEndImageContext();
        
    }
    
    
    return newImage;
    
}


@end


