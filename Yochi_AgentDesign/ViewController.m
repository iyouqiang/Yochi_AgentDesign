//
//  ViewController.m
//  Yochi_AgentDesign
//
//  Created by Yochi·Kung on 2017/7/19.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "ViewController.h"

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
}

- (IBAction)shareQQZone:(id)sender {
    NSLog(@"qq空间分享");
}

- (IBAction)shareWechat:(id)sender {
    NSLog(@"微信分享");
}

- (IBAction)shareCirclefriends:(id)sender {
    NSLog(@"朋友圈分享");
}

- (IBAction)shareSina:(id)sender {
    NSLog(@"新浪分享");
}

- (IBAction)shareCopy:(id)sender {
    NSLog(@"复制");
}

- (IBAction)wechatLogin:(id)sender {
    NSLog(@"微信登录");
}

- (IBAction)qqLogin:(id)sender {
    NSLog(@"QQ登录");
}

- (IBAction)sinaLogin:(id)sender {
    NSLog(@"新浪登录");
}

- (IBAction)wechatPay:(id)sender {
    NSLog(@"微信支付");
}

- (IBAction)alipay:(id)sender {
    NSLog(@"支付宝支付");
}

@end
