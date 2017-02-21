//
//  VKSAAppMacro.h
//  VKProprietorAssistant
//
//  Created by wolfire on 7/21/15.
//  Copyright (c) 2015 vanke. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef VKProprietorAssistant_ProprietorMacro_h
#define VKProprietorAssistant_ProprietorMacro_h


//#define REQUEST_ConfigURL               [VKGloablDAO sharedInstance].serverUrl


#define vCFBundleShortVersionStr        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define SHAREDAPPLICATION               [UIApplication sharedApplication]
#define APPDELEGATE                     SHAREDAPPLICATION.delegate

// Default date format
#define DEFAULT_DATE_FORMAT             @"yyyy-MM-dd HH:mm:ss"
#define DEFAULT_REQUEST_TIMEOUT         16.0f
#define DEFAULT_PROGRESS_DELAY          1.0f

// Public keys for NSUserDefaultCenter
#define QiNiuMessage                    @"QiNiuMessageKey"

// ------


// Default page size
#define DEFAULT_PAGE_SIZE               20
// 加载时的提示文案
#define kDefaultTipLodingString         @"正在加载..."
// 分页加载
typedef NS_ENUM(NSUInteger, LoadType) {
    LoadTypeFirstPage = 0 ,  // 加载第一页
    LoadTypeNextPage,   // 加载下一页
};

#endif
