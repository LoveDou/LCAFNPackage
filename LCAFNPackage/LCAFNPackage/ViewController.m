//
//  ViewController.m
//  LCAFNPackage
//
//  Created by luochao on 2017/3/7.
//  Copyright © 2017年 altamob. All rights reserved.
//

#import "ViewController.h"
#import "LCHTTPSessionManager.h"
#import "NSJSONSerialization+LCJSONUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *header =  @{
                              @"X-BBJ-DeviceId":@"745b5016066f4061a120a15136ec5a61",
                              @"Content-Type":@"application/json",
                              @"X-AppChannel":@"appstore_5",
                              @"X-AppVersion":@"1.5.0",
                              @"X-OS":@"ios",
                              @"X-Product":@"cn.ubaby.ubaby",
                              @"X-UserId":@"11050822",
                              @"X-UserAge":@"1472227200000"
                              };
    
    [[LCHTTPSessionManager lc_manager] GET:@"childlock.htm"
                                    header:header
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObj) {
                                       NSLog(@"success------>>%@",responseObj);
                                   }
                                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       NSLog(@"error------->>%@",error);
                                   }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
