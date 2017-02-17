//
//  TargetConfigMacros.h
//  carlife
//  target配置管理
//  Created by Sky on 17/1/12.
//  Copyright © 2017年 Sky. All rights reserved.
//

#ifndef TargetConfigMacros_h
#define TargetConfigMacros_h

#ifdef DEBUG  //开发环境
//输出转换成DDLog
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#define NSLog(...) DDLogVerbose(__VA_ARGS__)

#else   //其它环境
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#define NSLog(...) DDLogVerbose(__VA_ARGS__)

#endif

#endif /* TargetConfigMacros_h */
