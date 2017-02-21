//
//  VKPhotoPicker.h
//  VKProprietorAssistant
//
//  Created by wolfire on 9/14/15.
//  Copyright (c) 2015 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VKPhotoPicker, PhotoPickerModel;

#define BACKGROUD_SIZE              CGSizeMake(288, 88)
#define IMAGES_IN_ROW               3
#define DELETE_WIDTH                24
#define IMAGE_GAP                   16
#define kImageWidth                 85.0
#define kImageX                     16.0

typedef NS_ENUM(NSInteger, ImageUploadState) {
    ImageUploadStateNotBegin = 0,
    ImageUploadStateSuccess,
    ImageUploadStateFailed,
    
};

@protocol VKPhotoPickerDelegate <NSObject>

@optional

- (void)photoPicker:(VKPhotoPicker *)photoPicker didFinishPickImages:(NSArray *)images AtIndex:(NSInteger)index;
- (void)photoPicker:(VKPhotoPicker *)photoPicker didDeleteImageAtIndex:(NSInteger)index;

@end

@interface VKPhotoPicker : UIControl

@property (weak, nonatomic) UIViewController <VKPhotoPickerDelegate> *delegate;
@property (assign, nonatomic) NSInteger maxCount;
@property (assign, atomic) BOOL isSpecialForAvatar;
@property (nonatomic, strong)PhotoPickerModel *viewModel;
@property (nonatomic, assign) ImageUploadState imageUploadState;
@property (strong, nonatomic, readonly) NSMutableArray *pickedImages;

@property (nonatomic, assign) CGFloat pointY;

- (id)initWithFrame:(CGRect)frame photoPickerDelegate:(UIViewController <VKPhotoPickerDelegate> *)delegate;
- (void)uploadAllImage;

@end


@interface PhotoPickerModel : NSObject;

@property (nonatomic, strong) NSMutableArray *pickedImages;

- (void)removeImageAtIndex:(NSInteger)index;
- (void)addImageData:(UIImage *)image atIndex:(NSInteger)index;
- (NSString *)allImageRequestSting;

// 配置图片上传参数
- (void)prepareImageParamsWithImage:(UIImage *)image;
// 上传文件
- (void)uploadFileWithImageDic:(NSDictionary *)imageDic;
- (ImageUploadState)checkAllImageUploadState;
@end
