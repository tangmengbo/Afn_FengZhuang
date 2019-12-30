//
//  ViewController.m
//  FengZhuang_AfnNetWork
//
//  Created by 唐蒙波 on 2019/12/30.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "ViewController.h"
#import "HTTPModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [HTTPModel xt_sendVerifyCode:@"15829782534"
                            type:@"1"
                        callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        
        
    }];
    
    [HTTPModel xt_login:[NSNumber numberWithInt:5]
                 mobile:@"18888888888"
                 openId:nil
                smsCode:@"111111"
               password:nil
               callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if(status==0)
        {
            NSLog(@"%@",[responseObject objectForKey:@"data"]);
        }
    }];
}


@end
