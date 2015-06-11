//
//  ViewController.m
//  IOS_Core Telephony
//
//  Created by Bourbon on 13-10-21.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>


@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSLog(@"carrier1:%@",[carrier description]);
    
    //当 iPhone 漫游到了其他网路的时候，就会执行这段 block
    info.subscriberCellularProviderDidUpdateNotifier =
    ^(CTCarrier *carrier)
    {
        NSLog(@"carrier2:%@",[carrier description]);
    };
    
    //获取移动国家码
    NSString *mcc = [carrier mobileCountryCode];
    NSLog(@"mcc:%@",mcc);
    //获取移动网络码
    NSString *mnc = [carrier mobileNetworkCode];
    NSLog(@"mnc:%@",mnc);
    //判断运营商
    if ([[mcc substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"460"])
    {
        NSInteger MNC = [[mnc substringWithRange:NSMakeRange(0, 2)] intValue];
        switch (MNC)
        {
            case 00:
            case 02:
            case 07:
                NSLog(@"China Mobile") ;
            case 01:
            case 06:
                NSLog(@"China Unicom");
            case 03:
            case 05:
                NSLog(@"China Telecom");
            case 20:
                NSLog(@"China Tietong");
            default:
                break;
        }
    }
    
    //监控是不是有电话打进来、正在接听、或是已经挂断
    CTCallCenter *center = [[CTCallCenter alloc] init];
    center.callEventHandler = ^(CTCall *call)
    {
        NSLog(@"call:%@",[call description]);
    };

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
