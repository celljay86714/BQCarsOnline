//
//  Color.h
//  VKProprietorAssistant
//
//  Created by admin on 15/12/10.
//  Copyright © 2015年 Vanke. All rights reserved.
//

#ifndef Color_h
#define Color_h

// F1 Topbar颜色
#define kTopbarColor            [UIColor uxy_colorFromHexString:@"#FCFBF9"]
// F2 辅助色1 
#define kAssistColor_1          [UIColor uxy_colorFromHexString:@"#EBEAE0"]
// F3 全局背景颜色
#define kCommonBackgroudColor   [UIColor uxy_colorFromHexString:@"#F5F3EF"]
// F4 辅助色2
#define kAssistColor_2          [UIColor uxy_colorFromHexString:@"#DDDBCE"]
// Z1 主色
#define kMainColor              [UIColor uxy_colorFromHexString:@"#F7AB38"]
// Z2 主色点击
#define kMainHiglightColor      [UIColor uxy_colorFromHexString:@"#D79531"]
// Z3
#define kTextColor_Z3          VKColorFromRGB(243, 152, 0)
// J1 警告色
#define kAlertColor             [UIColor uxy_colorFromHexString:@"#DD5A36"]
// J2 警告色点击
#define kAlertHightligtColor    [UIColor uxy_colorFromHexString:@"#CF4822"]
// T1 文本颜色
#define kCommonTextColor        [UIColor uxy_colorFromHexString:@"#393939"]
// T2 辅助文本色
#define kAssistTextColor        [UIColor uxy_colorFromHexString:@"#909090"]
// 171，171，171的字体颜色
#define kTextColor_171          VKColorFromRGB(171, 171, 171)



//#define WKColorStyle_RED RGB(255, 85, 85)
//#define WKColorStyle_RED_HIGHLIGHTED RGB(255, 170, 170)
#define WKColorStyle_RED2                       [UIColor uxy_colorFromHexString:@"ff7f2a"]
#define WKColorStyle_RED                        [UIColor uxy_colorFromHexString:@"ff5000"]
#define WKColorStyle_RED_HIGHLIGHTED            [UIColor uxy_colorFromHexString:@"ff7f2a"]
#define WKColorStyle_RED                        [UIColor uxy_colorFromHexString:@"ff5000"]
#define WKColorStyle_BLUE                       [UIColor uxy_colorFromHexString:@"2a7fff"]
#define WKColorStyle_BLUE_HIGHLIGHTED           [UIColor uxy_colorFromHexString:@"5599ff"]
#define WKColorStyle_GRAY_3C                    [UIColor uxy_colorFromHexString:@"3c3c3c"]
#define WKColorStyle_GRAY_78                    [UIColor uxy_colorFromHexString:@"787878"]
#define WKColorStyle_GRAY_96                    [UIColor uxy_colorFromHexString:@"969696"]
#define WKColorStyle_GRAY_222222                [UIColor uxy_colorFromHexString:@"222222"]
#define WKColorStyle_GRAY_F0                    [UIColor uxy_colorFromHexString:@"F0F0F0"]
#define WKLINECOLOR                             [UIColor uxy_colorFromHexString:@"DCDCDC"]

#define WKColorStyle_GRAY                       RGB(236, 236, 236)
#define WKColorStyle_GRAY_HIGHLIGHTED           RGB(230, 230, 230)
#define WKColorStyle_GRAY_PLACEHOLDER           RGB(204, 204, 204)

#define VKSALightGrayColor              VKColorFromHexValue(0xE9E9E9)
#define VKDefaultGreen                  VKColorFromRGB(0, 153, 73)
#define VKDefaultYellow                 VKColorFromRGB(243, 152, 0)
#define VKDefaultBackgroundColor        VKColorFromHexValue(0xF2F0ED)
#define VKDefaultHeaderColor            VKColorFromHexValue(0xFAF8F5)
#define VKDefaultBorderColor            VKColorFromHexValue(0xE6E4E1)
#define VKDefaultTextColor              VKColorFromHexValue(0x393939)
#define VKDefaultDescriptColor          VKColorFromHexValue(0x909090)
#define AnimationBackgroundColor        (id)UXYColorFromRGBA(46, 46, 51, 0.7).CGColor

#define WKCOLORStyle_ORG [WKUtil colorWithHexString:@"FF9955"]

#define VKColorFromRGBA(r, g, b, a)                 [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]
#define VKColorFromRGB(r, g, b)                     VKColorFromRGBA(r, g, b, 1.0f)
#define VKColorFromHexAndAlpha(h, a)                VKColorFromRGBA(((h  >> 16) & 0xFF), ((h >> 8) & 0xFF), (h & 0xFF), a)
#define VKColorFromHexValue(h)                      VKColorFromHexAndAlpha(h, 1.0f)


// Sizes
#define SCREEN_BOUNDS                   [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH                    SCREEN_BOUNDS.size.width
#define SCREEN_HEIGHT                   SCREEN_BOUNDS.size.height
#define BOTTOM(object)                  (object.frame.origin.y + object.frame.size.height)
#define RIGHT(object)                   (object.frame.origin.x + object.frame.size.width)
#define LEFT(object)                    (object.frame.origin.x)
#define TOP(object)                     (object.frame.origin.y)
#define ORIGIN(object)                  (object.frame.origin)
#define ORIGINX(object)                 (object.frame.origin.x)
#define ORIGINY(object)                 (object.frame.origin.y)
#define SIZE(object)                    (object.frame.size)
#define WIDTH(object)                   (object.frame.size.width)
#define HEIGHT(object)                  (object.frame.size.height)



#pragma mark - *************** 新版 颜色值
// 全部背景色
#define kBackgroundColor   VKColorFromRGB(252, 251, 249)

#define kButtonEnableColor VKColorFromRGB(247, 171, 56)
// 按钮不可点击时的颜色
#define kButtomDisableColor VKColorFromRGBA(247, 171, 56, 0.50)


#pragma mark - *************** 新版 字体
// 	'PingFangSC-Ultralight'
//  'PingFangSC-Regular'
//  'PingFangSC-Semibold'
//  'PingFangSC-Thin'
//  'PingFangSC-Light'
//  'PingFangSC-Medium'

#define FontNameAndSize(fontName, fontSize)   ([UIFont fontWithName:fontName size:fontSize])

#define FontPingFangSC_Regular_Size(size) FontNameAndSize(@"PingFangSC-Regular", size)
#define FontPingFangSC_Light_Size(size)   FontNameAndSize(@"PingFangSC-Light"  , size)
#define FontPingFangSC_Medium_Size(size)  FontNameAndSize(@"PingFangSC-Medium" , size)
#define FontPingFangSC_Semibold_Size(size)  FontNameAndSize(@"PingFangSC-Semibold" , size)


#endif /* Color_h */
