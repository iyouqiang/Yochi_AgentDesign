//
//  SharePayWeChat.m
//  EPark-Base
//
//  Created by 小强强 on 2017/6/23.
//  Copyright © 2017年 ecaray. All rights reserved.
//

#import "SharePayWeChat.h"
#import "SharePayErrorUtility.h"
#import "WXApi.h"
#define WXAPPID @""

@interface SharePayWeChat ()<WXApiDelegate>

@property (nonatomic,copy) SharePayComplationBlcok complation;

@end

@implementation SharePayWeChat


- (instancetype)init{

    self = [super init];

    if (self) {

        //单独工程直接填入微信key
        BOOL isSuccess  = [WXApi registerApp:WXAPPID];//[WXApi registerApp:WXAPPID withDescription:@"SharePay_weixin"];


        if (isSuccess) {

            NSLog(@"微信注册成功！");
        }
    }
    
    return self;
}


/** 9.0以前回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

/** 9.0以后回调 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:	(NSDictionary<NSString*, id> *)options
{

    return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
}

/** 分享 */
- (void)shareTitle:(NSString *)title message:(NSString *)message imgUrl:(NSString *)imgUrl shareUrl:(NSString *)shareUrl controller:(UIViewController*)controller isCircleFriends:(BOOL)circleFriends isQQZone:(BOOL)qqZone withComplation:(SharePayComplationBlcok)complation
{
    if (!([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])) {

        complation(@"您未安装微信或当前版本不支持",[SharePayErrorUtility create:SharePay_ErrorAPPNotInstalled]);
        return;
    }
    
    _complation = complation;
    
    // 微信分享
    // 创建发送对象实例
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO; // 媒体多媒体选择其一

    if (circleFriends) {

        sendReq.scene = 1; //0 = 好友列表 1 = 朋友圈 2 = 收藏 // 默认好友列表
    }

    // 创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = title;
    urlMessage.description = message;

    // 使用默认本地图片
    if (imgUrl.length > 0 && imgUrl) {

        [urlMessage setThumbData: [NSData dataWithContentsOfURL:[NSURL  URLWithString:imgUrl]]];
    }else {

        [urlMessage setThumbImage:[UIImage imageNamed:@"ECParkingIcon.png"]];
    }

    // 创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = shareUrl;

    // 完成发送对象是咧
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;

    // 发送分享内容
    [WXApi sendReq:sendReq];
}

/** 唤醒支付 */
- (void)payWithCharge:(NSDictionary*)chargeInfo controller:(UIViewController*)controller scheme:(NSString*)scheme withComplation:(SharePayComplationBlcok)complation
{
    if (!([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])) {

        complation(nil,[SharePayErrorUtility create:SharePay_ErrorAPPNotInstalled]);
        return;
    }

    _complation = complation;
    NSString* timeStamp = [chargeInfo objectForKey:@"timestamp"];
    PayReq *request     = [[PayReq alloc] init];
    request.partnerId   = [chargeInfo objectForKey:@"partnerid"];
    request.prepayId    = [chargeInfo objectForKey:@"prepayid"];
    request.package     = [chargeInfo objectForKey:@"parampackage"];
    request.nonceStr    = [chargeInfo objectForKey:@"noncestr"];
    request.timeStamp   = [timeStamp intValue];
    request.sign        = [chargeInfo objectForKey:@"sign"];
    [WXApi sendReq:request];
}

/** 获取token后回调 */
- (void)loginAuthRequestComplation:(SharePayComplationBlcok)complation
{
    _complation = complation;
    
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"wechat_Login_Yochi";
    [WXApi sendReq:req];
}


/** 微信回调 回调 */
- (void)onResp:(BaseResp*)resp {

    /** 支付回调 */
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:

                if (_complation) {
                    _complation(@"支付成功",nil);
                }

                break;
            case WXErrCodeCommon:

                if (_complation) {
                    _complation(nil,[SharePayErrorUtility create:SharePay_Errorfailure]);
                }

                break;
            case WXErrCodeUserCancel:

                if (_complation) {
                    _complation(nil,[SharePayErrorUtility create:SharePay_ErrorCancelled]);
                }
                break;
            default:
                if (_complation) {
                    _complation(nil,[SharePayErrorUtility create:SharePay_Errorfailure]);
                }

                break;
        }
    }

    /** 分享回调 */
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;

        if (sendResp.errCode == WXSuccess) {

            if (_complation) {
                _complation(@"分享成功", nil);
            }

        }else if (sendResp.errCode == WXErrCodeUserCancel) {

            if (_complation) {

                _complation(nil,[SharePayErrorUtility create:SharePay_ErrorCancelled]);
            }

        }else {

            if (_complation) {
                _complation(nil,[SharePayErrorUtility create:SharePay_Errorfailure]);
            }
        }
    }
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        
        SendAuthResp *sendResp = (SendAuthResp *)resp;
        /** 获取token */
        NSString *tokenURL = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"填appid", @"填secret", sendResp.code];
        
         /** 刷新token */
        //NSString *refreshTokenURL = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",@"填appid", @"填获取到的refresh_token"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [session dataTaskWithURL:[NSURL URLWithString:tokenURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            NSError *errorInfo;
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorInfo];
            
            NSLog(@"object : %@ errorInfo : %@", object, errorInfo);
            
        }];
    }
}

@end
