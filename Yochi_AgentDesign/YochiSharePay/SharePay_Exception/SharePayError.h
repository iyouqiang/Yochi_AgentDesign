//
//  SharePayError.h
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 带字典可以使用参数使用如下key */

/** 微信 */
FOUNDATION_EXTERN NSString *const SharePayWECHATPAYKEY;

/** 支付宝 */
FOUNDATION_EXTERN NSString *const SharePayALIPAYKEY;

/** 腾讯 */
FOUNDATION_EXTERN NSString *const SharePayTENCENTKEY;

/** 拷贝 */
FOUNDATION_EXTERN NSString *const SharePayCOPYKEY;

/** 新浪微博 */
FOUNDATION_EXTERN NSString *const SharePaySINAKEY;

typedef NS_ENUM(NSUInteger,SharePay_ErrorOption){

    /** 成功 */
    SharePay_Success = 1,

    /** 失败 */
    SharePay_Errorfailure,

    /** 取消 */
    SharePay_ErrorCancelled,
    
    /** 没有安装APP */
    SharePay_ErrorAPPNotInstalled,

    /** 正在进行中 */
    SharePay_ErrorProcessed,

    /** 参数为空 */
    SharePay_ErrorParameterIsNil,

    /** 请求超时 */
    SharePay_ErrorRequestTimeOut,
    
    /** 无效渠道 */
    SharePay_ErrorInvalidChannel
};

@interface SharePayError : NSObject

@property (nonatomic, assign) SharePay_ErrorOption errorOption;

/** 获取异常信息 */
- (NSString *)getExceptionMessage;

@end
