//
//  SharePayContext.m
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import "SharePayContext.h"
#import "SharePayProtocol.h"
#import "SharePayErrorUtility.h"

@interface SharePayContext ()

@property (nonatomic, strong) id<SharePayProtocol> sharepaySate;
@property (nonatomic, strong) NSDictionary *channelDic;

@end

@implementation SharePayContext

+ (instancetype)shareContext
{
    static SharePayContext *sharecontext = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        sharecontext = [[SharePayContext alloc] init];
        
    });

    return sharecontext;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
    
        _channelDic = @{[NSString stringWithFormat:@"%lu",SharePay_WeChatChannel]:@"SharePayWeChat",
                        [NSString stringWithFormat:@"%lu",SharePay_WeChatFriendCircleChannel]:@"SharePayWeChat",
                        [NSString stringWithFormat:@"%lu",SharePay_TencentQQChannel]:@"SharePayTencent",
                        [NSString stringWithFormat:@"%lu",SharePay_TencentQQZoneChannel]:@"SharePayTencent",
                        [NSString stringWithFormat:@"%lu",SharePay_AliPayChannel]:@"SharePayAliPay",
                        [NSString stringWithFormat:@"%lu",SharePay_SinaChannel]:@"SharePaySina",
                        [NSString stringWithFormat:@"%lu",SharePay_CopyChannel]:@"SharePayCopy"};
    }
    
    return self;
}

/** 第三方登录 */
- (void)loginPlatform:(SharePayChannel)loginplatform withComplation:(SharePayComplationBlcok)complation
{
    /** 渠道验证 */
    if (![SharePayErrorUtility invalidChannel:loginplatform withComplation:complation]) {
        return;
    }
    
    NSString *channelType = [NSString stringWithFormat:@"%lu",loginplatform];
    NSString *className = _channelDic[channelType];
    _sharepaySate = [[NSClassFromString(className) alloc] init];
    
    if ([_sharepaySate respondsToSelector:@selector(loginAuthRequestComplation:)]) {
        [_sharepaySate loginAuthRequestComplation:complation];
    }
}

/** 分享 */
- (void)sharingplatform:(SharePayChannel)sharingplatform title:(NSString *)title message:(NSString *)message imgUrl:(NSString *)imgUrl shareUrl:(NSString *)shareUrl controller:(UIViewController*)controller withComplation:(SharePayComplationBlcok)complation;
{
    /** 渠道验证 */
    if (![SharePayErrorUtility invalidChannel:sharingplatform withComplation:complation]) {
        return;
    }
    
    BOOL isQQZone = NO;
    BOOL isCircleFriend = NO;
    
    if (sharingplatform == SharePay_WeChatFriendCircleChannel ) {
        
        isCircleFriend = YES;
    }else if (sharingplatform == SharePay_TencentQQZoneChannel) {
        
        isQQZone = YES;
    }
    
    NSString *channelType = [NSString stringWithFormat:@"%lu",sharingplatform];
    NSString *className = _channelDic[channelType];
    _sharepaySate = [[NSClassFromString(className) alloc] init];
    
    if ([_sharepaySate respondsToSelector:@selector(shareTitle:message:imgUrl:shareUrl:controller:isCircleFriends:isQQZone:withComplation:)]) {
        [_sharepaySate shareTitle:title message:message imgUrl:message shareUrl:shareUrl controller:controller isCircleFriends:isCircleFriend isQQZone:isQQZone withComplation:complation];
    }
}

/** 1、唤醒支付 */
- (void)payWithCharge:(NSDictionary*)chargeInfo channel:(SharePayChannel)payChannel controller:(UIViewController*)controller scheme:(NSString*)scheme withComplation:(SharePayComplationBlcok)complation
{
    /** 新增支付渠道需要 用到controller 是需验证是否为空 */
    if (![SharePayErrorUtility invalidCharge:chargeInfo withComplation:complation]) {
        return;
    }
    
    /** 渠道验证 */
    if (![SharePayErrorUtility invalidChannel:payChannel withComplation:complation]) {
        return;
    }
    
    NSString *channelType = [NSString stringWithFormat:@"%lu",payChannel];
    NSString *className = _channelDic[channelType];
    _sharepaySate = [[NSClassFromString(className) alloc] init];
    
    if ([_sharepaySate respondsToSelector:@selector(payWithCharge:controller:scheme:withComplation:)]) {
        [_sharepaySate payWithCharge:chargeInfo controller:controller scheme:scheme withComplation:complation];
    }
}

/** 2、9.0以前回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [_sharepaySate application:application openURL:url sourceApplication:sourceApplication annotation:application];
}

/** 3、9.0以后回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:	(NSDictionary<NSString*, id> *)options
{
    return [_sharepaySate application:application openURL:url options:options];
}

@end
