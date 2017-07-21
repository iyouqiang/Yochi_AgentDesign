//
//  SharePayContext.h
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharePayProtocol.h"
@interface SharePayContext : NSObject

+ (instancetype)shareContext;

/** 第三方登录 */
- (void)loginPlatform:(SharePayChannel)loginplatform withComplation:(SharePayComplationBlcok)complation;

/** 分享 */
- (void)sharingplatform:(SharePayChannel)sharingplatform title:(NSString *)title message:(NSString *)message imgUrl:(NSString *)imgUrl shareUrl:(NSString *)shareUrl controller:(UIViewController*)controller withComplation:(SharePayComplationBlcok)complation;

/** 唤醒支付 */
- (void)payWithCharge:(NSDictionary*)chargeInfo channel:(SharePayChannel)payChannel controller:(UIViewController*)controller scheme:(NSString*)scheme withComplation:(SharePayComplationBlcok)complation;

/** 9.0以前回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/** 9.0以后回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:	(NSDictionary<NSString*, id> *)options;

@end
