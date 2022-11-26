//
//  AppDelegate.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/25.
//

#import "AppDelegate.h"
#import "YIPDemoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow new];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[YIPDemoViewController new]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
