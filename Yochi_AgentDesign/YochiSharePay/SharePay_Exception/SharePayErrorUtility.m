//
//  SharePayErrorUtility.m
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import "SharePayErrorUtility.h"
#import "SharePayProtocol.h"
@implementation SharePayErrorUtility

+ (SharePayError *)create:(SharePay_ErrorOption)code
{
    SharePayError *error = [[SharePayError alloc] init];
    error.errorOption = code;
    return error;
}

+ (BOOL)invalidCharge:(NSDictionary*)chargeInfo withComplation:(SharePayComplationBlcok)complation
{
    if (!chargeInfo || chargeInfo.count == 0) {
        
        complation(@"参数不能为空",[SharePayErrorUtility create:SharePay_ErrorParameterIsNil]);
        return NO;
    }

    return YES;
}

+ (BOOL)invalidChannel:(SharePayChannel)channel withComplation:(SharePayComplationBlcok)complation
{
    if (channel == SharePay_WeChatChannel ||
        channel == SharePay_WeChatFriendCircleChannel ||
        channel == SharePay_TencentQQChannel ||
        channel == SharePay_TencentQQZoneChannel ||
        channel == SharePay_AliPayChannel ||
        channel == SharePay_SinaChannel ||
        channel == SharePay_CopyChannel) {
        
        return YES;
    }
    
    if (complation) {
        
        complation(@"无效渠道",[SharePayErrorUtility create:SharePay_ErrorInvalidChannel]);
    }
    
    return NO;
}

@end
