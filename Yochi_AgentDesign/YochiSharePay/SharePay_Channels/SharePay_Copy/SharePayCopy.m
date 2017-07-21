//
//  SharePayCopy.m
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import "SharePayCopy.h"
#import "SharePayErrorUtility.h"
@implementation SharePayCopy

/** 复制 */
- (void)shareTitle:(NSString *)title message:(NSString *)message imgUrl:(NSString *)imgUrl shareUrl:(NSString *)shareUrl controller:(UIViewController*)controller isCircleFriends:(BOOL)circleFriends isQQZone:(BOOL)qqZone withComplation:(SharePayComplationBlcok)complation
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = shareUrl;
    if (pasteboard.string.length > 0) {

        complation(@"复制成功", [SharePayErrorUtility create:SharePay_Success]);
    }
}


@end
