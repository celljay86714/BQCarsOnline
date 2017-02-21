//
//  VKCategory.h
//  VanKeOwner
//
//  Created by Eric on 15/9/14.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WIDTH_IPAD 1024
#define HEIGHT_IPHONE_5 568
#define HEIGHT_IPHONE_4 480
#define HEIGHT_IPAD 768
#define HEIGHT_IPHONE 320

#define IS_IPHONE_4 ( [ [ UIScreen mainScreen ] bounds ].size.height == HEIGHT_IPHONE_4 )


@interface UIView (ergodicAndSetFrame)
- (void)ergodicSubviewsWithBlock:(BOOL (^)(UIView *view))handler DeepLoop:(BOOL)deepLoop;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setOrigin:(CGPoint)origin;
- (void)setSize:(CGSize)size;
- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;
- (void)addCommonShadow;
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
+ (UILabel *)allocNewLabelWith:(NSString *)string;

@end


@interface UITableView (EndRefreshing)

/**
 *  @author Vanke
 *
 *   根据数据状态判断是否还能下拉下一页
 *
 *  @param status YES为没有下一页的数据了
 */
-(void)endRefrreshingFromStatus:(BOOL)status;

@end


@interface NSBundle (XIB)

- (UIView *)viewWithTag:(NSInteger)tag NibName:(NSString *)nibNime Scale:(CGFloat)scale;

@end

@interface UIColor (VVRandomColor)

+ (UIColor *)randomColor;
- (UIImage*)createImageWithColor;

@end


@interface NSObject(TopController)

- (UIViewController *)windowTopOfController;
- (void)showSVProgressViewShowErrorInfo:(NSError *)error;
- (void)showSVProgressViewShowErrorInfo:(id)error hasMoreData:(void (^)(BOOL hasNoMoreData))block;
- (void)pushSourceCameraControllerWithActionBlock:(void (^)())block;
- (BOOL)whetherIsYouZhan:(NSString *)string;
- (NSMutableAttributedString *)subStringWithColor:(UIColor *)color atRang:(NSRange)rang withString:(NSString *)string;
- (NSMutableAttributedString *)subStringWithString:(NSString *)string lineSpace:(CGFloat)space font:(int)font;
//压缩图片
- (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
@end


@interface NSDictionary(writeFileInDomain)

- (BOOL)writeToFileWithName:(NSString*)fileName Folder:(NSString*)folderName;
+ (id)dictionaryByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName;

@end

@interface NSMutableDictionary(writeFileInDomain)

+ (id)dictionaryByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName;

@end

@interface NSMutableArray(writeFileInDomain)

+ (id)arrayByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName;

@end

@interface NSArray(writeFileInDomain)

- (BOOL)writeToFileWithName:(NSString*)fileName Folder:(NSString*)folderName;
+ (id)arrayByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName;

@end

@interface NSData(writeFileInDomain)

- (BOOL)writeToFileWithName:(NSString*)fileName Folder:(NSString*)folderName;
+ (id)dataByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName;


@end
