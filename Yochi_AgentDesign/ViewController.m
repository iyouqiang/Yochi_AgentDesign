//
//  ViewController.m
//  Yochi_AgentDesign
//
//  Created by Yochi·Kung on 2017/7/19.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "ViewController.h"

#import "SharePayContext.h"

@interface ViewController ()

- (IBAction)shareQQ:(id)sender;
- (IBAction)shareQQZone:(id)sender;
- (IBAction)shareWechat:(id)sender;
- (IBAction)shareCirclefriends:(id)sender;
- (IBAction)shareSina:(id)sender;
- (IBAction)shareCopy:(id)sender;

- (IBAction)wechatLogin:(id)sender;
- (IBAction)qqLogin:(id)sender;
- (IBAction)sinaLogin:(id)sender;

- (IBAction)wechatPay:(id)sender;
- (IBAction)alipay:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareQQ:(id)sender {
    NSLog(@"qq分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_TencentQQChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)shareQQZone:(id)sender {
    NSLog(@"qq空间分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_TencentQQZoneChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://f.hiphotos.baidu.com/image/pic/item/6c224f4a20a44623f42ca6789022720e0df3d7c2.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
    
}

- (IBAction)shareWechat:(id)sender {
    NSLog(@"微信分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_WeChatChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)shareCirclefriends:(id)sender {
    NSLog(@"朋友圈分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_WeChatFriendCircleChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)shareSina:(id)sender {
    NSLog(@"新浪分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_SinaChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)shareCopy:(id)sender {
    NSLog(@"复制");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_CopyChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)wechatLogin:(id)sender {
    NSLog(@"微信登录");
    
    [[SharePayContext shareContext] loginPlatform:SharePay_WeChatChannel withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)qqLogin:(id)sender {
    NSLog(@"QQ登录");
    
    [[SharePayContext shareContext] loginPlatform:SharePay_TencentQQChannel withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)sinaLogin:(id)sender {
    NSLog(@"新浪登录");
    
    [[SharePayContext shareContext] loginPlatform:SharePay_SinaChannel withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)wechatPay:(id)sender {
    NSLog(@"微信支付");
    
    [[SharePayContext shareContext] payWithCharge:@{/*微信支付字典*/} channel:SharePay_WeChatChannel controller:nil scheme:@"AgentDesign" withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (IBAction)alipay:(id)sender {
    NSLog(@"支付宝支付");
    
    NSString *alipay = @"支付宝参数";
    
    [[SharePayContext shareContext] payWithCharge:@{SharePayALIPAYKEY : alipay} channel:SharePay_AliPayChannel controller:nil scheme:@"AgentDesign" withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}
@end
