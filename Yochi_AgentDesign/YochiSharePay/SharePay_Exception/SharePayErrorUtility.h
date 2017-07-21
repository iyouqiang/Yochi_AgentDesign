//
//  SharePayErrorUtility.h
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharePayProtocol.h"
#import "SharePayError.h"

@interface SharePayErrorUtility : NSObject

+ (SharePayError *)create:(SharePay_ErrorOption)code;

+ (BOOL)invalidCharge:(NSDictionary*)chargeInfo withComplation:(SharePayComplationBlcok)complation;

+ (BOOL)invalidChannel:(SharePayChannel)channel withComplation:(SharePayComplationBlcok)complation;

@end
