//
//  SharePayProtocol.h
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SharePayError.h"

/** 处理结果回调 */
typedef void (^SharePayComplationBlcok)(NSString* result,SharePayError *error);

/** 支付渠道 */
typedef NS_ENUM(NSUInteger,SharePayChannel){
    
    /** 微信 */
    SharePay_WeChatChannel = 1,
    
    SharePay_WeChatFriendCircleChannel,
    
    /** 腾讯*/
    SharePay_TencentQQChannel,
    
    SharePay_TencentQQZoneChannel,
    
    /** 支付宝 */
    SharePay_AliPayChannel,
    
    /** 新浪 */
    SharePay_SinaChannel,
    
    /** Copy */
    SharePay_CopyChannel,
};

@protocol SharePayProtocol <NSObject>

@optional

/** 9.0以前回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/** 9.0以后回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:	(NSDictionary<NSString*, id> *)options;

/** 登录认证 */
- (void)loginAuthRequestComplation:(SharePayComplationBlcok)complation;

/** 分享 */
- (void)shareTitle:(NSString *)title message:(NSString *)message imgUrl:(NSString *)imgUrl shareUrl:(NSString *)shareUrl controller:(UIViewController*)controller isCircleFriends:(BOOL)circleFriends isQQZone:(BOOL)qqZone withComplation:(SharePayComplationBlcok)complation;

/** 唤醒支付 */
- (void)payWithCharge:(NSDictionary*)chargeInfo controller:(UIViewController*)controller scheme:(NSString*)scheme withComplation:(SharePayComplationBlcok)complation;

@end
