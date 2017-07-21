//
//  SharePayError.m
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import "SharePayError.h"

NSString *const SharePayWECHATPAYKEY = @"SharePayWECHATPAY";
NSString *const SharePayALIPAYKEY    = @"SharePayALIPAY";
NSString *const SharePayTENCENTKEY   = @"SharePayTENCENT";
NSString *const SharePayCOPYKEY      = @"SharePayCOPY";
NSString *const SharePaySINAKEY      = @"SharePaySINA";

@interface SharePayError ()

@property (nonatomic, strong) NSDictionary *errorInfo;

@end

@implementation SharePayError

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _errorInfo = @{[NSString stringWithFormat:@"%lu",SharePay_Success]:@"操作成功",
                       [NSString stringWithFormat:@"%lu",SharePay_Errorfailure]:@"操作失败",
                       [NSString stringWithFormat:@"%lu",SharePay_ErrorCancelled]:@"操作取消",
                       [NSString stringWithFormat:@"%lu",SharePay_ErrorAPPNotInstalled]:@"未安装APP",
                       [NSString stringWithFormat:@"%lu",SharePay_ErrorProcessed]:@"正在进行中",
                       [NSString stringWithFormat:@"%lu",SharePay_ErrorParameterIsNil]:@"参数不能为空",
                       [NSString stringWithFormat:@"%lu",SharePay_ErrorRequestTimeOut]:@"请求超时",
                       [NSString stringWithFormat:@"%lu",SharePay_ErrorInvalidChannel]:@"无效渠道"};
    }
    
    return self;
}

/** 获取异常信息 */
- (NSString *)getExceptionMessage
{
    NSString *errorType = [NSString stringWithFormat:@"%lu",self.errorOption];
    return _errorInfo[errorType];
}

@end
