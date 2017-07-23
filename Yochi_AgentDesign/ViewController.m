//
//  ViewController.m
//  Yochi_AgentDesign
//
//  Created by Yochi·Kung on 2017/7/19.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "ViewController.h"
#import "SnailFullView.h"
#import "SnailPopupController.h"
#import "SharePayContext.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *ShareBtn;

- (IBAction)ShowPopViewAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.ShareBtn.layer.cornerRadius = 50;
}

- (SnailFullView *)fullView {
    
    SnailFullView *fullView = [[SnailFullView alloc] initWithFrame:self.view.frame];
    NSArray *array = @[@"QQ好友",
                       @"QQ空间",
                       @"微信好友",
                       @"朋友圈",
                       @"新浪微博",
                       @"微信支付",
                       @"支付宝支付",
                       @"更多",
                       @"微博登录",
                       @"QQ登录",
                       @"微信登录",
                       @"复制"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:array.count];
    for (NSString *string in array) {
        SnailIconLabelModel *item = [SnailIconLabelModel new];
        item.icon = [UIImage imageNamed:[NSString stringWithFormat:@"shared_%@", string]];
        item.text = string;
        [models addObject:item];
    }
    fullView.models = models;
    return fullView;
}

- (IBAction)ShowPopViewAction:(id)sender {
    
    SnailFullView *full = [self fullView];
    full.didClickFullView = ^(SnailFullView * _Nonnull fullView) {
        [self.sl_popupController dismiss];
    };
    
    __weak ViewController *weakSelf = self;
    
    full.didClickItems = ^(SnailFullView *fullView, NSInteger index) {
        self.sl_popupController.didDismiss = ^(SnailPopupController * _Nonnull popupController) {
            
            __strong ViewController *strongSelf = weakSelf;
            if (index == 0) {
                [strongSelf shareQQ];
            }else if (index == 1) {
                
                [strongSelf shareQQZone];
            }else if (index == 2) {
                
                [strongSelf shareWechat];
            }else if (index == 3) {
                
                [strongSelf shareCirclefriends];
            }else if (index == 4) {

                [strongSelf shareSina];
            }else if (index == 5) {
                
                [strongSelf wechatPay];
            }else if (index == 6) {
                
                [strongSelf alipay];
            }else if (index == 7) {
                
                NSLog(@"更多不回调");
            }else if (index == 8) {
                
                [strongSelf sinaLogin];
            }else if (index == 9) {
                
                [strongSelf qqLogin];
            }else if (index == 10) {
                
                [strongSelf wechatLogin];
            }else if (index == 11) {
                
                [strongSelf shareCopy];
            }else {
                
                NSLog(@"Error");
            }
        };
        
        [fullView endAnimationsCompletion:^(SnailFullView *fullView) {
            [self.sl_popupController dismiss];
        }];
    };
    
    self.sl_popupController = [SnailPopupController new];
    self.sl_popupController.maskType = PopupMaskTypeDefault;
    self.sl_popupController.allowPan = YES;
    [self.sl_popupController presentContentView:full];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareQQ {
    NSLog(@"qq分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_TencentQQChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)shareQQZone {
    NSLog(@"qq空间分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_TencentQQZoneChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://f.hiphotos.baidu.com/image/pic/item/6c224f4a20a44623f42ca6789022720e0df3d7c2.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
    
}

- (void)shareWechat {
    NSLog(@"微信分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_WeChatChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)shareCirclefriends {
    NSLog(@"朋友圈分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_WeChatFriendCircleChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)shareSina {
    NSLog(@"新浪分享");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_SinaChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)shareCopy {
    NSLog(@"复制");
    
    [[SharePayContext shareContext] sharingplatform:SharePay_CopyChannel title:@"Yochi·Kung" message:@"我是大佬" imgUrl:@"http://up.qqjia.com/z/face01/face06/facejunyong/junyong04.jpg" shareUrl:@"http://www.baidu.com" controller:nil withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)wechatLogin {
    NSLog(@"微信登录");
    
    [[SharePayContext shareContext] loginPlatform:SharePay_WeChatChannel withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)qqLogin {
    NSLog(@"QQ登录");
    
    [[SharePayContext shareContext] loginPlatform:SharePay_TencentQQChannel withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)sinaLogin {
    NSLog(@"新浪登录");
    
    [[SharePayContext shareContext] loginPlatform:SharePay_SinaChannel withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)wechatPay {
    NSLog(@"微信支付");
    
    [[SharePayContext shareContext] payWithCharge:@{/*微信支付字典*/} channel:SharePay_WeChatChannel controller:nil scheme:@"AgentDesign" withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

- (void)alipay {
    NSLog(@"支付宝支付");
    
    NSString *alipay = @"支付宝参数";
    
    [[SharePayContext shareContext] payWithCharge:@{SharePayALIPAYKEY : alipay} channel:SharePay_AliPayChannel controller:nil scheme:@"AgentDesign" withComplation:^(NSString *result, SharePayError *error) {
        
        NSLog(@"result : %@", result);
    }];
}

@end
