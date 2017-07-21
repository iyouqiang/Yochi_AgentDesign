//
//  SharePayAliPay.m
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//


#import "SharePayAliPay.h"
#import "SharePayErrorUtility.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SharePayContext.h"

@implementation SharePayAliPay

/** 9.0以前回调 #import "SharePay.h" */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {

    }];

    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {

    }];

    return YES;
}

/** 9.0以后回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:	(NSDictionary<NSString*, id> *)options
{
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {

    }];

    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {

    }];

    return YES;
}

/** 唤醒支付 */
- (void)payWithCharge:(NSDictionary*)chargeInfo controller:(UIViewController*)controller scheme:(NSString*)scheme withComplation:(SharePayComplationBlcok)complation
{
    /*
     payparams = "_input_charset=\"UTF-8\"&it_b_pay=\"30m\"&notify_url=\"http://app.zhuzhouparking.com:8080/fa/direct-module=pay_service=Trade_method=trade_api=AliPay.wapNotify_merid=0001\"&out_trade_no=\"20170625085328560132224358686787\"&partner=\"2088521145324414\"&payment_type=\"1\"&return_url=\"http://app.zhuzhouparking.com:8080/fa/direct-module=pay_service=Trade_method=trade_api=AliPay.wapReturn_merid=0001\"&seller_id=\"zzgysygs@163.com\"&service=\"mobile.securitypay.pay\"&sign=\"6c4da3d5b508a3edb75dcc48ac99d57b\"&sign_type=\"MD5\"&subject=\"\U5145\U503c,\U652f\U4ed8\U5b9d\"&total_fee=\"0.01\"";
     */
    
    [[AlipaySDK defaultService] payOrder:[chargeInfo objectForKey:SharePayALIPAYKEY] fromScheme:scheme callback:^(NSDictionary *resultDic) {

        NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];

        switch (resultStatus) {
            case 9000:
            {
                complation(@"支付成功",nil);
            }
                break;
            case 6001:
            {
                /** 取消支付 */
                complation(@"取消支付",[SharePayErrorUtility create:SharePay_ErrorCancelled]);
            }
                break;
            case 8000:
            {
                /** 正在处理 */
                complation(@"正在处理",[SharePayErrorUtility create:SharePay_ErrorProcessed]);
            }
                break;

            default:

                /** 支付失败 */
                complation(@"支付失败",[SharePayErrorUtility create:SharePay_Errorfailure]);

                break;
        }
    }];
}

@end
