//
//  SharePayTencent.m
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import "SharePayTencent.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "SharePayErrorUtility.h"

#define TencentAPPID @"1106137739"

@interface SharePayTencent ()<TencentSessionDelegate>

@property (nonatomic,strong) TencentOAuth *tencentOAuth;
@property (nonatomic,copy) SharePayComplationBlcok complation;

@end

@implementation SharePayTencent

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentAPPID andDelegate:self];
        _tencentOAuth.redirectURI = @"www.qq.com";
    }
    
    return self;
}

/** 9.0以前回调 #import "SharePay.h" */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [TencentOAuth HandleOpenURL:url];
}

/** 9.0以后回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:	(NSDictionary<NSString*, id> *)options
{
    return [TencentOAuth HandleOpenURL:url];
}

/** 分享 */
- (void)shareTitle:(NSString *)title message:(NSString *)message imgUrl:(NSString *)imgUrl shareUrl:(NSString *)shareUrl controller:(UIViewController*)controller isCircleFriends:(BOOL)circleFriends isQQZone:(BOOL)qqZone withComplation:(SharePayComplationBlcok)complation
{
    _complation = complation;
    
    QQApiNewsObject *newsObj =  nil;
    
    if (!imgUrl && imgUrl.length == 0) {
        
        UIImage *defaultImg = [UIImage imageNamed:@""];
        
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareUrl] title:title description:message previewImageData:UIImagePNGRepresentation(defaultImg)];
    }else {
    
       newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareUrl] title:title description:message previewImageURL:[NSURL URLWithString:imgUrl]];
    }
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    if (qqZone) {
    
        /** 分享到QQ空间 */
        QQApiSendResultCode sent =[QQApiInterface SendReqToQZone:req];
        [self handleSendResult:sent];
    }else {
        
        /** 分享QQ */
        QQApiSendResultCode sent =[QQApiInterface sendReq:req];
        [self handleSendResult:sent];
    }
}

/** 登录 */
- (void)loginAuthRequestComplation:(SharePayComplationBlcok)complation
{
    _complation = complation;
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_SHARE,
                            nil];
    [_tencentOAuth authorize:permissions];
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPITIMNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装TIM" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        case EQQAPITIMNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIVERSIONNEEDUPDATE:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"当前QQ版本太低，需要更新" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case ETIMAPIVERSIONNEEDUPDATE:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"当前QQ版本太低，需要更新" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
         
            if (_complation) {
                
                _complation(@"分享成功", [SharePayErrorUtility create:SharePay_Success]);
            }
            break;
        }
    }
}

- (void)tencentDidLogin
{
    NSLog(@"登录成功");
    
    if (_complation) {
        
        _complation(@"登录成功", [SharePayErrorUtility create:SharePay_Success]);
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"取消登录");
    
    if (_complation) {
        
        _complation(@"取消登录", [SharePayErrorUtility create:SharePay_ErrorCancelled]);
    }
}

- (void)tencentDidNotNetWork
{
    NSLog(@"网络超时");
    
    if (_complation) {
        
        _complation(@"网络超时", [SharePayErrorUtility create:SharePay_ErrorRequestTimeOut]);
    }
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    NSLog(@"extraParams : %@", extraParams);
    
    return [NSArray arrayWithObjects:
            kOPEN_PERMISSION_GET_USER_INFO,
            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
            kOPEN_PERMISSION_ADD_SHARE,
            nil];
}

- (void)getVipRichInfoResponse:(APIResponse*) response
{
    NSLog(@"response : %@", response);
}

@end
