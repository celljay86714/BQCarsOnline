//
//  VKCategory.m
//  VanKeOwner
//
//  Created by Eric on 15/9/14.
//  Copyright (c) 2015年 Jay. All rights reserved.
//

#import "VKCategory.h"

@implementation NSBundle (XIB)

- (UIView *)viewWithTag:(NSInteger)tag NibName:(NSString *)nibNime Scale:(CGFloat)scale {
    UIView *view = nil;
    NSArray *array = [self loadNibNamed:nibNime owner:nil options:nil];
    for (UIView *v in array) {
        if ([v isKindOfClass:[UIView class]] && v.tag == tag) {
            view = v;
            break;
        }
    }
    if (!view) {
        DDLogInfo(@"nil View with this tag.");
    } else {
        [view ergodicSubviewsWithBlock:^BOOL (UIView *v) {
            v.autoresizesSubviews = YES;
            if ([v isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)v;
                label.font = [UIFont fontWithName:label.font.fontName size:label.font.pointSize / scale];
            }
            v.autoresizingMask = UIViewAutoresizingNone;
            return NO;
        } DeepLoop:YES];
        
        view.frame = CGRectMake(view.frame.origin.x / scale, view.frame.origin.y / scale, view.frame.size.width / scale, view.frame.size.height / scale);
        
        [view ergodicSubviewsWithBlock:^BOOL (UIView *v) {
             return NO;
        }
                              DeepLoop:YES];
    }
    return view;
}

@end

@implementation UIView (ergodicAndSetFrame)

- (UIViewController *) firstAvailableUIViewController {
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}
- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

- (void)ergodicSubviewsWithBlock:(BOOL (^)(UIView *view))handler DeepLoop:(BOOL)deepLoop {
    for (UIView *v in self.subviews) {
        if (deepLoop) [v ergodicSubviewsWithBlock:handler DeepLoop:deepLoop];
        BOOL r = handler(v);
        if (r) break;
    }
}


+ (UILabel *)allocNewLabelWith:(NSString *)string{

    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 50, 20)];//allocate titleText
    titleText.backgroundColor = [UIColor clearColor];
    [titleText setText:string];
    titleText.alpha=0;
    
    return titleText;
}


-(void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
    
}
-(void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
-(void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
-(void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(void)setOrigin:(CGPoint)origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}
-(void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
-(void)setCenterX:(CGFloat)x
{
    self.center = CGPointMake(x, self.center.y);
}
-(void)setCenterY:(CGFloat)y
{
    self.center = CGPointMake(self.center.x,y);
}
-(void)addCommonShadow
{
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = .6;
    
    CGRect shadowFrame = self.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowPath = shadowPath;
}


@end

@implementation UITableView (EndRefreshing)


-(void)endRefrreshingFromStatus:(BOOL)status{

    [self.mj_header endRefreshing];
    
    if (status == NO) {
        
        [self.mj_footer  endRefreshing];
    }
    else
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mj_footer  endRefreshingWithNoMoreData];
        });
}

@end

@implementation UIColor (VVRandomColor)
+ (UIColor *)randomColor {
    CGFloat hue = (arc4random() % 256 / 256.0);    //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (UIImage*)createImageWithColor {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end


@implementation NSObject(TopController)

-(UIViewController *)windowTopOfController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(void)showSVProgressViewShowErrorInfo:(NSError *)error{
    if ([error isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *errorDic = (NSDictionary *)error;
        if ([errorDic[@"code"] integerValue] == 0) {
            [SVProgressHUD dismiss];
        } else {
            NSString *errorString = errorDic[@"error"];
            [SVProgressHUD showInfoWithStatus:errorString.length>0?errorString:@"请求失败"];
        }
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }
    
}


- (void)showSVProgressViewShowErrorInfo:(id)error hasMoreData:(void (^)(BOOL hasNoMoreData))block{

    if ([error isKindOfClass:[NSDictionary class]]) {
        NSDictionary *errorDic = (NSDictionary *)error;
        NSNumber *status = errorDic [@"code"];
        if ([status intValue] == 0) {
            [SVProgressHUD showWithStatus:@"没有更多数据"];
            if (block) {
                block(YES);
            }
            return;
        } else {
            if ([errorDic[@"code"] integerValue] == 1) {
                [SVProgressHUD dismiss];
            } else{
                NSString *errorString = errorDic[@"error"];
                [SVProgressHUD showInfoWithStatus:errorString.length > 0 ? errorString : @"请求失败"];
            }
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }
    if (block) {
        block(NO);
    }
}

- (void)pushSourceCameraControllerWithActionBlock:(void (^)())block {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusAuthorized) {               // 已授权状态，可以直接扫码
            if (block) {
                block();
            }
        } else if (authorizationStatus == AVAuthorizationStatusNotDetermined) {     // 授权状态未定，需要用户决定是否可以访问相机
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    if (block) {
                        block();
                    }
                }
            }];
        }  else {                                                                   // 受限状态，无法直接扫码，需要用户在设置中允许App访问相机
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"访问受限"
                                                            message:@"请在设备的\"设置-隐私-相机-住这儿\"中允许访问相机"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"好的", nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"功能受限"
                                                        message:@"当前设备不支持此功能"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"知道了", nil];
        [alert show];
    }
    
}

- (BOOL)whetherIsYouZhan:(NSString *)string{

    if (!(string.length>0)) {
        return NO;
    }
    else
    {
        string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url =[NSURL URLWithString:string];
        NSString *regex = @"^(.+\\.)*(koudaitong\\.com|youzan\\.com|kdt\\.im)$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return [predicate evaluateWithObject:url.host];

    }
}

-(NSMutableAttributedString *)subStringWithColor:(UIColor *)color atRang:(NSRange)rang withString:(NSString *)string{
    
    NSMutableAttributedString *attribuStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attribuStr addAttribute:NSForegroundColorAttributeName value:color range:rang];
    return attribuStr;
}

-(NSMutableAttributedString *)subStringWithString:(NSString *)string lineSpace:(CGFloat)space font:(int)font{

    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *contentStyle = [[NSMutableParagraphStyle alloc] init];
    contentStyle.lineSpacing = space;
    [content addAttribute:NSParagraphStyleAttributeName value:contentStyle range:NSMakeRange(0, content.length)];
    
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, content.length)];
    return content;
}

- (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{

    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
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
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        DDLogInfo(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;

}

@end


@implementation NSDictionary(writeFileInDomain)
-(BOOL)writeToFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSString *domainPath = [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    NSString *writePath = [domainPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *dirStr = [NSString stringWithFormat:@"%@/%@",domainPath,folderName];
    BOOL existDir = ([manager contentsOfDirectoryAtPath:dirStr error:nil] != nil);
    if(!existDir) [manager createDirectoryAtPath:dirStr withIntermediateDirectories:NO attributes:nil error:nil];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data writeToFile:writePath atomically:YES];
}
+(id)dictionaryByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSString *domainPath = [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    NSString *readPath = [domainPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    NSData *data = [NSData dataWithContentsOfFile:readPath];
    NSDictionary *dict = nil;
    if(data != nil) dict = [NSDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return dict;
}
@end
@implementation NSMutableDictionary(writeFileInDomain)

+(id)dictionaryByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSDictionary *dict = [NSDictionary dictionaryByReadFileWithName:fileName Folder:folderName];
    if(dict) return [NSMutableDictionary dictionaryWithDictionary:dict];
    else return nil;
}

@end
@implementation NSMutableArray(writeFileInDomain)
+(id)arrayByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSArray *array = [NSArray arrayByReadFileWithName:fileName Folder:folderName];
    if(array) return [NSMutableArray arrayWithArray:array];
    else return nil;
}
@end
@implementation NSArray(writeFileInDomain)
-(BOOL)writeToFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSString *domainPath = [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    NSString *writePath = [domainPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *dirStr = [NSString stringWithFormat:@"%@/%@",domainPath,folderName];
    BOOL existDir = ([manager contentsOfDirectoryAtPath:dirStr error:nil] != nil);
    if(!existDir) [manager createDirectoryAtPath:dirStr withIntermediateDirectories:NO attributes:nil error:nil];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data writeToFile:writePath atomically:YES];
}
+(id)arrayByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSString *domainPath = [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    NSString *readPath = [domainPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    
    NSData *data = [NSData dataWithContentsOfFile:readPath];
    NSArray *array = nil;
    if(data != nil) array = [NSArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return array;
}
@end
@implementation NSData(writeFileInDomain)
-(BOOL)writeToFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSString *domainPath = [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    NSString *writePath = [domainPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *dirStr = [NSString stringWithFormat:@"%@/%@",domainPath,folderName];
    BOOL existDir = ([manager contentsOfDirectoryAtPath:dirStr error:nil] != nil);
    if(!existDir) [manager createDirectoryAtPath:dirStr withIntermediateDirectories:NO attributes:nil error:nil];
    return [self writeToFile:writePath atomically:YES];
}
+(id)dataByReadFileWithName:(NSString*)fileName Folder:(NSString*)folderName
{
    NSString *domainPath = [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    NSString *readPath = [domainPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    NSData *data = [NSData dataWithContentsOfFile:readPath];
    return data;
}
@end

