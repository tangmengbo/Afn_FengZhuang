//
//  AppDelegate.m
//  FengZhuang_AfnNetWork
//
//  Created by 唐蒙波 on 2019/12/30.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ViewController   * vc = [[ViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;

    return YES;
}




@end
