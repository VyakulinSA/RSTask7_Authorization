//
//  AppDelegate.m
//  RSTask7
//
//  Created by Вякулин Сергей on 04.07.2021.
//

#import "AppDelegate.h"
#import "RSViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    RSViewController *rootVC = [[RSViewController alloc] initWithNibName:@"RSViewController" bundle:nil];
    [window setRootViewController:rootVC];

    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
